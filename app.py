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
    'White Spot': 'Menaikkan suhu air: Tingkatkan suhu air secara perlahan hingga 28-30°C selama beberapa hari untuk mempercepat siklus hidup parasit.\nPenggunaan obat: Gunakan obat anti-parasit seperti malachite green atau formalin sesuai petunjuk dosis pada kemasan.\nKarantina: Pindahkan ikan yang terinfeksi ke tank karantina untuk menghindari penyebaran ke ikan lain.\nAerasi: Pastikan ada cukup oksigen dalam air karena peningkatan suhu dapat mengurangi kadar oksigen terlarut.',
    'Black Spot': 'Penggunaan obat anti-parasit: Gunakan praziquantel atau metronidazole sesuai dosis yang dianjurkan.\nKarantina: Pisahkan ikan yang terinfeksi untuk mencegah penularan.\nMembersihkan kolam: Bersihkan kolam dan buang siput yang bisa menjadi inang perantara parasit.',
    'Cloudy Eyes': 'Penggantian air: Lakukan penggantian air secara rutin untuk menjaga kualitas air.\nPenggunaan obat antibiotik: Jika disebabkan oleh infeksi bakteri, gunakan antibiotik seperti erythromycin atau tetracycline.\nPemberian makanan berkualitas: Pastikan ikan mendapatkan makanan yang kaya vitamin A untuk kesehatan mata.',
    'Dropsy': 'Isolasi: Segera isolasi ikan yang terinfeksi, Pastikan bak air diberikan PK sepucuk jari, garam, heater, dan obat kuning.\nPenggunaan antibiotik: Berikan antibiotik seperti kanamycin atau metronidazole yang dicampur dalam makanan.\nPerbaikan kualitas air: Pastikan kondisi air bersih dan memiliki parameter yang sesuai.',
    'Fin/Tail Rot': 'Penggunaan antiseptik: Oleskan antiseptik seperti betadine pada bagian yang terinfeksi.\nPenggunaan antibiotik: Berikan antibiotik dalam air atau makanan seperti amoxicillin atau tetracycline.\nPenggantian air: Pastikan air dalam kondisi bersih dan bebas dari polutan.',
    'Kutu Jangkar': 'Pengangkatan manual: Gunakan pinset untuk mengangkat kutu jangkar dari tubuh ikan dengan hati-hati.\nPenggunaan antiparasit: Gunakan antiparasit seperti dimilin atau potassium permanganate sesuai dosis yang dianjurkan.\nKarantina: Pisahkan ikan yang terinfeksi dan obati dalam tank karantina.'
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
    'G1': 0.6, 'G2': 0.7, 'G3': 0.9, 'G4': 0.8, 'G5': 0.7, 'G6': 0.8, 'G7': 0.7, 'G8': 0.9, 'G9': 0.9, 'G10': 0.6, 'G11': 0.9, 'G12': 0.8, 'G13': 0.7, 'G14': 0.8, 'G15': 0.7
}

def combine_cf(cf1, cf2):
    if cf1 >= 0 and cf2 >= 0:
        return cf1 + cf2 * (1 - cf1)
    elif cf1 < 0 and cf2 < 0:
        return cf1 + cf2 * (1 + cf1)
    else:
        return (cf1 + cf2) / (1 - min(abs(cf1), abs(cf2)))

def diagnosa_penyakit_cf(gejala_cf):
    disease_cf = {}
    for disease, disease_symptoms in symptoms.items():
        combined_cf = 0.0
        for symptom in disease_symptoms:
            if symptom in gejala_cf:
                combined_cf = combine_cf(combined_cf, gejala_cf[symptom])
        disease_cf[disease] = combined_cf

    hasil_diagnosa = max(disease_cf, key=disease_cf.get)
    cf_persen = disease_cf[hasil_diagnosa] * 100
    return hasil_diagnosa, treatments[hasil_diagnosa], cf_persen

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
    if not data:
        return jsonify({"error": "Input tidak boleh kosong"}), 400

    selected_disease = data.get('disease')
    selected_symptoms = data.get('symptoms', [])
    
    if not selected_disease or selected_disease not in symptoms:
        return jsonify({"error": "Penyakit yang dipilih tidak valid atau kosong"}), 400
    if not selected_symptoms:
        return jsonify({"error": "Gejala tidak boleh kosong"}), 400

    total_weight = sum(bobot_gejala[gejala] for gejala in symptoms[selected_disease] if gejala in bobot_gejala)
    matched_weight = sum(bobot_gejala[gejala] for gejala in selected_symptoms if gejala in symptoms[selected_disease] and gejala in bobot_gejala)
    accuracy = (matched_weight / total_weight) * 100 if total_weight > 0 else 0
    selected_symptoms_desc = [gejala_mapping[gejala] for gejala in selected_symptoms if gejala in gejala_mapping]

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

    gejala_cf = {symptom: bobot_gejala[symptom] for symptom in gejala if symptom in bobot_gejala}
    hasil, treatment, cf_persen = diagnosa_penyakit_cf(gejala_cf)
    return jsonify({
        "hasil_diagnosa": hasil,
        "treatment": treatment,
        "certainly_factor": f"{cf_persen:.2f}%"
    })

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5001, debug=True)
