from flask import Flask, request, jsonify
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

# backward chaining
gejalaPenyakit = {
    'White Spot': {
        'symptoms': [
            'Terdapat bintik-bintik putih pada tubuh ikan',
            'Menggosokkan tubuh ke benda keras',
            'Kesulitan bernapas'
        ],
        'treatment': 'Gunakan obat anti-parasit yang mengandung formalin atau malachite green.'
    },
    'Black Spot': {
        'symptoms': [
            'Terdapat bintik-bintik hitam pada tubuh ikan',
            'Lemas atau menurunnya kekebalan tubuh',
            'Produksi lendir berlebih'
        ],
        'treatment': 'Lakukan perawatan dengan menggunakan praziquantel atau trichlorfon.'
    },
    'Cloudy Eyes': {
        'symptoms': [
            'Mata berkabut',
            'Menggosokkan mata ke benda keras',
            'Kesulitan dalam berenang'
        ],
        'treatment': 'Perbaiki kualitas air dan tambahkan antibiotik jika diperlukan.'
    },
    'Dropsy': {
        'symptoms': [
            'Perut membengkak',
            'Sisik berdiri seperti nanas',
            'Mata menonjol'
        ],
        'treatment': 'Isolasi ikan yang terinfeksi dan berikan antibiotik seperti kanamycin.'
    },
    'Fin/Tail Rot': {
        'symptoms': [
            'Sirip dan ekor membusuk',
            'Tulang sirip dan ekor buram',
            'Lapisan putih pada kulit'
        ],
        'treatment': 'Gunakan antibiotik seperti erythromycin atau melakukan penggantian air yang lebih sering.'
    },
    'Kutu Jangkar': {
        'symptoms': [
            'Terdapat cacing yang menempel pada tubuh',
            'Sering menggesekkan tubuh pada dinding',
            'Lemas atau menurunnya kekebalan tubuh'
        ],
        'treatment': 'Gunakan obat anti-parasit yang mengandung diflubenzuron atau dimilin.'
    },
}

# forward chaining
def diagnosa_penyakit(koi):
    if 'G1' in koi and 'G2' in koi and 'G3' in koi:
        return "White Spot", gejalaPenyakit['White Spot']['treatment']
    elif 'G1' in koi and 'G2' in koi and 'G4' in koi:
        return "Black Spot", gejalaPenyakit['Black Spot']['treatment']
    elif 'G5' in koi and 'G6' in koi and 'G7' in koi:
        return "Cloudy Eyes", gejalaPenyakit['Cloudy Eyes']['treatment']
    elif 'G8' in koi and 'G9' in koi and 'G10' in koi and 'G11' in koi:
        return "Dropsy", gejalaPenyakit['Dropsy']['treatment']
    elif 'G1' in koi and 'G12' in koi and 'G13' in koi:
        return "Fin/Tail Rot", gejalaPenyakit['Fin/Tail Rot']['treatment']
    elif 'G1' in koi and 'G14' in koi and 'G15' in koi:
        return "Kutu Jangkar", gejalaPenyakit['Kutu Jangkar']['treatment']
    else:
        if 'G3' in koi:
            return "Kemungkinan penyakit White Spot", gejalaPenyakit['White Spot']['treatment']
        elif 'G4' in koi:
            return "Kemungkinan penyakit Black Spot", gejalaPenyakit['Black Spot']['treatment']
        elif 'G5' in koi or 'G6' in koi or 'G7' in koi:
            return "Kemungkinan penyakit Cloudy Eyes", gejalaPenyakit['Cloudy Eyes']['treatment']
        elif 'G12' in koi or 'G13' in koi:
            return "Kemungkinan penyakit Fin/Tail Rot", gejalaPenyakit['Fin/Tail Rot']['treatment']
        elif 'G14' in koi:
            return "Kemungkinan penyakit Kutu Jangkar", gejalaPenyakit['Kutu Jangkar']['treatment']
        elif 'G8' in koi or 'G9' in koi or 'G10' in koi or 'G11' in koi:
            return "Kemungkinan penyakit Dropsy", gejalaPenyakit['Dropsy']['treatment']
        else:
            return "Penyakit ikan koi tidak ditemukan. Segera lakukan karantina untuk penyembuhan ikan koi anda!", "Karantina dan konsultasi dengan ahli."

@app.route('/diseases', methods=['GET'])
def get_diseases():
    return jsonify(list(gejalaPenyakit.keys()))

@app.route('/symptoms', methods=['GET'])
def get_symptoms():
    disease = request.args.get('disease')
    if disease in gejalaPenyakit:
        return jsonify(gejalaPenyakit[disease]['symptoms'])
    return jsonify([])

@app.route('/treatment', methods=['GET'])
def get_treatment():
    disease = request.args.get('disease')
    if disease in gejalaPenyakit:
        return jsonify(gejalaPenyakit[disease]['treatment'])
    return jsonify([])

@app.route('/diagnosabackward', methods=['POST'])
def diagnose():
    data = request.get_json()
    selected_disease = data.get('disease')
    selected_symptoms = data.get('symptoms', [])
    
    if not selected_disease or selected_disease not in gejalaPenyakit:
        return jsonify({"error": "Invalid disease selected"}), 400

    total_symptoms = len(gejalaPenyakit[selected_disease]['symptoms'])
    matched_symptoms = len([symptom for symptom in selected_symptoms if symptom in gejalaPenyakit[selected_disease]['symptoms']])
    accuracy = (matched_symptoms / total_symptoms) * 100 if total_symptoms > 0 else 0
    
    return jsonify({
        "disease": selected_disease,
        "selected_symptoms": selected_symptoms,
        "accuracy": f"{accuracy:.2f}%",
        "treatment": gejalaPenyakit[selected_disease]['treatment']
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
