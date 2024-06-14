from flask import Flask, request, jsonify
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

diseases = ['White Spot', 'Black Spot', 'Cloudy Eyes', 'Dropsy', 'Fin/Tail Rot', 'Kutu Jangkar']
symptoms = {
    'White Spot': ['G1', 'G2', 'G3'],
    'Black Spot': ['G1', 'G2', 'G4'],
    'Cloudy Eyes': ['G5', 'G6', 'G7'],
    'Dropsy': ['G8', 'G9', 'G10', 'G11'],
    'Fin/Tail Rot': ['G1', 'G12', 'G13'],
    'Kutu Jangkar': ['G1', 'G14', 'G15']
}
treatments = {
    'White Spot': 'Gunakan obat anti-parasit yang mengandung formalin atau malachite green.',
    'Black Spot': 'Lakukan perawatan dengan menggunakan praziquantel atau trichlorfon.',
    'Cloudy Eyes': 'Perbaiki kualitas air dan tambahkan antibiotik jika diperlukan.',
    'Dropsy': 'Isolasi ikan yang terinfeksi dan berikan antibiotik seperti kanamycin.',
    'Fin/Tail Rot': 'Gunakan antibiotik seperti erythromycin atau melakukan penggantian air yang lebih sering.',
    'Kutu Jangkar': 'Gunakan obat anti-parasit yang mengandung diflubenzuron atau dimilin.'
}

gejala_mapping = {
    'G1': 'Menurunnya kekebalan tubuh atau lemas',
    'G2': 'Badan ikan kurus',
    'G3': 'Terdapat bintik-bintik putih pada tubuh ikan',
    'G4': 'Terdapat bintik-bintik hitam pada tubuh ikan',
    'G5': 'Mata berkabut',
    'G6': 'Produksi lendir berlebih',
    'G7': 'Mata menonjol',
    'G8': 'Badan gembur',
    'G9': 'Perut membengkak',
    'G10': 'Kesulitan dalam berenang',
    'G11': 'Sisik nanas atau mulai menanggal dari badan ikan',
    'G12': 'Sirip dan ekor mulai membusuk',
    'G13': 'Tulang sirip dan ekor buram',
    'G14': 'Terdapat cacing yang menempel pada tubuh',
    'G15': 'Sering menggesekkan tubuh pada dinding'
}

bobot_gejala = {
    'G1': 1.0, 'G2': 1.0, 'G3': 1.5, 'G4': 1.5, 'G5': 1.5, 'G6': 1.5, 'G7': 1.5, 'G8': 1.5, 'G9': 1.5, 'G10': 1.0, 'G11': 1.5, 'G12': 1.5, 'G13': 1.5, 'G14': 1.5, 'G15': 1.5
}

def diagnosa_penyakit(koi):
    if all(symptom in koi for symptom in symptoms['White Spot']):
        return "White Spot", treatments['White Spot']
    elif all(symptom in koi for symptom in symptoms['Black Spot']):
        return "Black Spot", treatments['Black Spot']
    elif all(symptom in koi for symptom in symptoms['Cloudy Eyes']):
        return "Cloudy Eyes", treatments['Cloudy Eyes']
    elif all(symptom in koi for symptom in symptoms['Dropsy']):
        return "Dropsy", treatments['Dropsy']
    elif all(symptom in koi for symptom in symptoms['Fin/Tail Rot']):
        return "Fin/Tail Rot", treatments['Fin/Tail Rot']
    elif all(symptom in koi for symptom in symptoms['Kutu Jangkar']):
        return "Kutu Jangkar", treatments['Kutu Jangkar']
    else:
        if any(symptom in koi for symptom in symptoms['White Spot']):
            return "Kemungkinan penyakit White Spot", treatments['White Spot']
        elif any(symptom in koi for symptom in symptoms['Black Spot']):
            return "Kemungkinan penyakit Black Spot", treatments['Black Spot']
        elif any(symptom in koi for symptom in symptoms['Cloudy Eyes']):
            return "Kemungkinan penyakit Cloudy Eyes", treatments['Cloudy Eyes']
        elif any(symptom in koi for symptom in symptoms['Fin/Tail Rot']):
            return "Kemungkinan penyakit Fin/Tail Rot", treatments['Fin/Tail Rot']
        elif any(symptom in koi for symptom in symptoms['Kutu Jangkar']):
            return "Kemungkinan penyakit Kutu Jangkar", treatments['Kutu Jangkar']
        elif any(symptom in koi for symptom in symptoms['Dropsy']):
            return "Kemungkinan penyakit Dropsy", treatments['Dropsy']
        else:
            return "Penyakit ikan koi tidak ditemukan. Segera lakukan karantina untuk penyembuhan ikan koi anda!", "Karantina dan konsultasi dengan ahli."


@app.route('/diseases', methods=['GET'])
def get_diseases():
    return jsonify(diseases)

@app.route('/symptoms', methods=['GET'])
def get_symptoms():
    disease = request.args.get('disease')
    if disease in symptoms:
        return jsonify([gejala_mapping[gejala] for gejala in symptoms[disease]])
    return jsonify([])

@app.route('/treatment', methods=['GET'])
def get_treatment():
    disease = request.args.get('disease')
    if disease in treatments:
        return jsonify(treatments[disease])
    return jsonify([])

@app.route('/diagnosabackward', methods=['POST'])
def diagnose():
    data = request.get_json()
    print("Received data:", data) 

    if not data:
        return jsonify({"error": "Input tidak boleh kosong"}), 400

    selected_disease = data.get('disease')
    selected_symptoms = data.get('symptoms', [])
    
    if not selected_disease or selected_disease not in symptoms:
        return jsonify({"error": "Penyakit yang dipilih tidak valid atau kosong"}), 400
    if not selected_symptoms:
        return jsonify({"error": "Gejala tidak boleh kosong"}), 400

    print("Selected Disease:", selected_disease) 
    print("Selected Symptoms:", selected_symptoms) 

    total_weight = sum(bobot_gejala[gejala] for gejala in symptoms[selected_disease] if gejala in bobot_gejala)
    matched_weight = sum(bobot_gejala[gejala] for gejala in selected_symptoms if gejala in symptoms[selected_disease] and gejala in bobot_gejala)
    accuracy = (matched_weight / total_weight) * 100 if total_weight > 0 else 0
    selected_symptoms_desc = [gejala_mapping[gejala] for gejala in selected_symptoms if gejala in gejala_mapping]

    print("Total Weight:", total_weight) 
    print("Matched Weight:", matched_weight) 
    print("Accuracy:", accuracy) 

    return jsonify({
        "disease": selected_disease,
        "selected_symptoms": selected_symptoms_desc,
        "accuracy": f"{accuracy:.2f}%",
        "treatment": treatments[selected_disease]
    })


@app.route('/diagnosaforward', methods=['POST'])
def diagnosa():
    data = request.json
    
    if not data:
        return jsonify({"error": "Input tidak boleh kosong"}), 400

    gejala = data.get('gejala', [])
    
    if not gejala:
        return jsonify({"error": "Gejala tidak boleh kosong"}), 400

    hasil, treatment = diagnosa_penyakit(gejala)
    return jsonify({
        "hasil_diagnosa": hasil,
        "treatment": treatment
    })

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5001, debug=True)
