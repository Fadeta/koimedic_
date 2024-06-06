from flask import Flask, request, jsonify
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

diseases = ['White Spot', 'Black Spot', 'Cloudy Eyes', 'Dropsy', 'Fin/Tail Rot', 'Kutu Jangkar']
symptoms = {
    'White Spot': ['Terdapat bintik-bintik putih pada tubuh ikan', 'Menggosokkan tubuh ke benda keras', 'Kesulitan bernapas'],
    'Black Spot': ['Terdapat bintik-bintik hitam pada tubuh ikan', 'Lemas atau menurunnya kekebalan tubuh', 'Produksi lendir berlebih'],
    'Cloudy Eyes': ['Mata berkabut', 'Menggosokkan mata ke benda keras', 'Kesulitan dalam berenang'],
    'Dropsy': ['Perut membengkak', 'Sisik berdiri seperti nanas', 'Mata menonjol'],
    'Fin/Tail Rot': ['Sirip dan ekor membusuk', 'Tulang sirip dan ekor buram', 'Lapisan putih pada kulit'],
    'Kutu Jangkar': ['Terdapat cacing yang menempel pada tubuh', 'Sering menggesekkan tubuh pada dinding', 'Lemas atau menurunnya kekebalan tubuh']
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
    'G1': 'Terdapat bintik-bintik putih pada tubuh ikan',
    'G2': 'Menggosokkan tubuh ke benda keras',
    'G3': 'Kesulitan bernapas',
    'G4': 'Terdapat bintik-bintik hitam pada tubuh ikan',
    'G5': 'Mata berkabut',
    'G6': 'Menggosokkan mata ke benda keras',
    'G7': 'Kesulitan dalam berenang',
    'G8': 'Perut membengkak',
    'G9': 'Sisik berdiri seperti nanas',
    'G10': 'Mata menonjol',
    'G11': 'Lemas atau menurunnya kekebalan tubuh',
    'G12': 'Sirip dan ekor membusuk',
    'G13': 'Tulang sirip dan ekor buram',
    'G14': 'Terdapat cacing yang menempel pada tubuh',
    'G15': 'Sering menggesekkan tubuh pada dinding'
}

def diagnosa_penyakit(koi):
    koi_symptoms = [gejala_mapping[gejala] for gejala in koi if gejala in gejala_mapping]
    if all(symptom in koi_symptoms for symptom in symptoms['White Spot']):
        return "White Spot", treatments['White Spot']
    elif all(symptom in koi_symptoms for symptom in symptoms['Black Spot']):
        return "Black Spot", treatments['Black Spot']
    elif all(symptom in koi_symptoms for symptom in symptoms['Cloudy Eyes']):
        return "Cloudy Eyes", treatments['Cloudy Eyes']
    elif all(symptom in koi_symptoms for symptom in symptoms['Dropsy']):
        return "Dropsy", treatments['Dropsy']
    elif all(symptom in koi_symptoms for symptom in symptoms['Fin/Tail Rot']):
        return "Fin/Tail Rot", treatments['Fin/Tail Rot']
    elif all(symptom in koi_symptoms for symptom in symptoms['Kutu Jangkar']):
        return "Kutu Jangkar", treatments['Kutu Jangkar']
    else:
        if any(symptom in koi_symptoms for symptom in symptoms['White Spot']):
            return "Kemungkinan penyakit White Spot", treatments['White Spot']
        elif any(symptom in koi_symptoms for symptom in symptoms['Black Spot']):
            return "Kemungkinan penyakit Black Spot", treatments['Black Spot']
        elif any(symptom in koi_symptoms for symptom in symptoms['Cloudy Eyes']):
            return "Kemungkinan penyakit Cloudy Eyes", treatments['Cloudy Eyes']
        elif any(symptom in koi_symptoms for symptom in symptoms['Fin/Tail Rot']):
            return "Kemungkinan penyakit Fin/Tail Rot", treatments['Fin/Tail Rot']
        elif any(symptom in koi_symptoms for symptom in symptoms['Kutu Jangkar']):
            return "Kemungkinan penyakit Kutu Jangkar", treatments['Kutu Jangkar']
        elif any(symptom in koi_symptoms for symptom in symptoms['Dropsy']):
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
        return jsonify(symptoms[disease])
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
    selected_disease = data.get('disease')
    selected_symptoms = data.get('symptoms', [])
    
    if not selected_disease or selected_disease not in symptoms:
        return jsonify({"error": "Invalid disease selected"}), 400

    total_symptoms = len(symptoms[selected_disease])
    matched_symptoms = len([symptom for symptom in selected_symptoms if symptom in symptoms[selected_disease]])
    accuracy = (matched_symptoms / total_symptoms) * 100 if total_symptoms > 0 else 0
    
    return jsonify({
        "disease": selected_disease,
        "selected_symptoms": selected_symptoms,
        "accuracy": f"{accuracy:.2f}%",
        "treatment": treatments[selected_disease]
    })

@app.route('/diagnosaforward', methods=['POST'])
def diagnosa():
    data = request.json
    gejala = data.get('gejala', [])
    hasil, treatment = diagnosa_penyakit(gejala)
    return jsonify({
        "hasil_diagnosa": hasil,
        "treatment": treatment
    })

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5001, debug=True)
