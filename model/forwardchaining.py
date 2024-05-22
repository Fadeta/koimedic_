from flask import Flask, request, jsonify
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

#backwardchaining
gejalaPenyakit = {
    'White Spot': [
        'Terdapat bintik-bintik putih pada tubuh ikan',
        'Menggosokkan tubuh ke benda keras',
        'Kesulitan bernapas'
    ],
    'Black Spot': [
        'Terdapat bintik-bintik hitam pada tubuh ikan',
        'Lemas atau menurunnya kekebalan tubuh',
        'Produksi lendir berlebih'
    ],
    'Cloudy Eyes': [
        'Mata berkabut',
        'Menggosokkan mata ke benda keras',
        'Kesulitan dalam berenang'
    ],
    'Dropsy': [
        'Perut membengkak',
        'Sisik berdiri seperti nanas',
        'Mata menonjol'
    ],
    'Fin/Tail Rot': [
        'Sirip dan ekor membusuk',
        'Tulang sirip dan ekor buram',
        'Lapisan putih pada kulit'
    ],
    'Kutu Jangkar': [
        'Terdapat cacing yang menempel pada tubuh',
        'Sering menggesekkan tubuh pada dinding',
        'Lemas atau menurunnya kekebalan tubuh'
    ],
}

#forwaerdchaining
def diagnosa_penyakit(koi):
    if 'G1' in koi and 'G2' in koi and 'G3' in koi:
        return "White Spot"
    elif 'G1' in koi and 'G2' in koi and 'G4' in koi:
        return "Black Spot"
    elif 'G5' in koi and 'G6' in koi and 'G7' in koi:
        return "Cloudy Eyes"
    elif 'G8' in koi and 'G9' in koi and 'G10' in koi and 'G11' in koi:
        return "Dropsy"
    elif 'G1' in koi and 'G12' in koi and 'G13' in koi:
        return "Fin/Tail Rot"
    elif 'G1' in koi and 'G14' in koi and 'G15' in koi:
        return "Kutu Jangkar"
    else:
        return "Penyakit ikan koi tidak ditemukan. Segera lakukan karantina untuk penyembuhan ikan koi anda!"

@app.route('/diseases', methods=['GET'])
def get_diseases():
    return jsonify(list(gejalaPenyakit.keys()))

@app.route('/symptoms', methods=['GET'])
def get_symptoms():
    disease = request.args.get('disease')
    if disease in gejalaPenyakit:
        return jsonify(gejalaPenyakit[disease])
    return jsonify([])

@app.route('/diagnosabackward', methods=['POST'])
def diagnose():
    data = request.get_json()
    selected_disease = data.get('disease')
    selected_symptoms = data.get('symptoms', [])
    
    if not selected_disease or selected_disease not in gejalaPenyakit:
        return jsonify({"error": "Invalid disease selected"}), 400

    total_symptoms = len(gejalaPenyakit[selected_disease])
    matched_symptoms = len([symptom for symptom in selected_symptoms if symptom in gejalaPenyakit[selected_disease]])
    accuracy = (matched_symptoms / total_symptoms) * 100 if total_symptoms > 0 else 0
    
    return jsonify({
        "disease": selected_disease,
        "selected_symptoms": selected_symptoms,
        "accuracy": f"{accuracy:.2f}%"
    })

@app.route('/diagnosaforward', methods=['POST'])
def diagnosa():
    data = request.json
    gejala = data.get('gejala', [])
    hasil = diagnosa_penyakit(gejala)
    return jsonify({"hasil_diagnosa": hasil})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5001, debug=True)
