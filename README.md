# Frontend 

## [ParaKnowledge AI](https://paraknowledge.ai)

For creating a new username and retrieving an API key, visit [ParaKnowledge AI](https://paraknowledge.ai). For support, contact [research@paraknowledge.ai](mailto:research@paraknowledge.ai).

![ParaKnowledge AI](./frontend.png?raw=true)


# `zcor_predict`

## Quickstart


```
curl -X POST -H "Content-Type: application/json" -d '[{"patient_id": "P000012", "sex": "M", "age": 89, "birth_date": "01-01-1921", "fips": "35644", "DX_record": [{"date": "12-16-2011", "code": "R09.02"}, {"date": "12-30-2011", "code": "H04.129"}, {"date": "12-30-2011", "code": "H02.109"}], "RX_record": [], "PROC_record": [{"date": "09-28-2012", "code": "71100"}]}]' "https://us-central1-pkcsaas-01.cloudfunctions.net/zcor_predict?target=IPF&api_key=APIKEY"
```


```
curl -X POST -H "Content-Type: application/json" -d '[{"patient_id": "P000012", "sex": "M", "age": 89, "birth_date": "01-01-1921", "fips": "35644", "DX_record": [{"date": "12-16-2011", "code": "R09.02"}, {"date": "12-30-2011", "code": "H04.129"}, {"date": "12-30-2011", "code": "H02.109"}], "RX_record": [], "PROC_record": [{"date": "09-28-2012", "code": "71100"}]}]' "https://us-central1-pkcsaas-01.cloudfunctions.net/zcor_predict?target=ILD&api_key=APIKEY"
```

Replace APIKEY with a valid api-key obtained by emailing support.

# Introduction 

`zcor_predict` is an EHR-based predictive algorithm designed to screen for a range of disorders using electronic health records. This tool currently supports screening for the following targets:

- IPF (Idiopathic Pulmonary Fibrosis)
- ILD (Interstitial Lung Disease)
- ASD (Autism Spectrum Disorder, only for young children)
- ADRD (Alzheimer's Disease and Related Dementia) pending

### Estimated Performance

- IPF - 88% AUC for predicting risk of IPF diagnosis 1 year ahead. [Onishchenko et al., Nature Medicine](https://www.science.org/doi/10.1126/sciadv.abf0354)
- ASD - 80% AUC for predicting risk of future ASD diagnosis in 2-year-olds. [Onishchenko et al., Science Advances](https://www.science.org/doi/10.1126/sciadv.abf0354)
- ADRD - 88% AUC for predicting risk of ADRD diagnosis 1 year ahead.

# API Documentation


`zcor_predict` is deployed as a cloud function and can be accessed via the following URL endpoint:

```
https://us-central1-pkcsaas-01.cloudfunctions.net/zcor_predict?target=TARGET&api_key=YOUR_API_KEY
```

Replace `TARGET` with either `IPF` or `ASD`, and `YOUR_API_KEY` with your actual API key. The service responds to POST requests containing patient data encoded as a JSON object.

### Input Format

The input should be a JSON object that consists of a list of dictionaries. Each dictionary contains a single patient record with the following fields:

- `patient_id` (required)
- `birth_date` (required) - Format: "MM-DD-YYYY".
- `sex` (optional) - Defaults to "F" if not provided.
- `DX_record` (required) - A list of dictionaries containing the patient's diagnostic codes in ICD10 or ICD9 format (`code`), along with the date of diagnosis (`date`).
- `RX_record` (optional, required for certain targets) - A list of dictionaries with the patient's prescription codes in NDC format (`code`), and the date of prescription (`date`).
- `PROC_record` (optional, required for certain targets) - A list of dictionaries with the patient's procedural codes in ICD, CPT, or HCPCS format (`code`), and the date of the procedure (`date`).

### Minimum Requirements:

- Essential fields: `patient_id`, `birth_date`, and `DX_record`.
- `DX_record` must have at least 2 diagnosis codes, recorded at least 1 week apart.
- We recommend a minimum 5 diagnosis codes in medical history for flags to be reliable

### Output Format

The service returns a JSON object with predictions, structured as follows:

```json
{
  "predictions": [
    {
      "error_code": "",
      "patient_id": "P000012",
      "predicted_risk": 0.005794344620009157,
      "probability": 0.8253881317184486
    }
  ],
  "target": "TARGET"
}
```

In this structure, `TARGET` will be either `IPF` or `ASD`, depending on the specified target in the request. Each entry in the `predictions` array corresponds to a patient's risk prediction for the specified disorder.


#### Interpretation

The `probability` is the probability of a patient to experience the target disorder in near future (the length of this future depends on teh model, but currently the "prediction window" is 1 year).
We recommend that for relable prediction, use decision thersholds greater than 90% or higher on this estimated probability.


### Example Inputs

#### Example 1: json input for Single Patient

```json
[
    {
        "patient_id": "P000038",
        "sex": "F",
        "birth_date": "01-01-2006",
        "DX_record": [
            {"date": "07-31-2006", "code": "Z38.00"},
            {"date": "08-07-2006", "code": "P59.9"},
            {"date": "08-29-2016", "code": "J01.90"}
        ],
        "RX_record": [
            {"date": "10-29-2011", "code": "rxLDA017"},
            {"date": "05-16-2015", "code": "rxIDG004"},
            {"date": "08-08-2015", "code": "rxIDG004"},
            {"date": "06-04-2016", "code": "rxIDD013"}
        ],
        "PROC_record": [
            {"date": "02-05-2007", "code": "90723"},
            {"date": "11-05-2007", "code": "J1100"}
        ]
    }
]
```


### Example 2: Complete `curl` command



```
curl -X POST -H "Content-Type: application/json" -d '[{"patient_id": "P000012", "sex": "M", "age": 89, "birth_date": "01-01-1921", "fips": "35644", "DX_record": [{"date": "01-08-2010", "code": "M15.9"}, {"date": "01-08-2010", "code": "I51.9"}], "RX_record": [], "PROC_record": [{"date": "12-30-2011", "code": "92014"},{"date": "09-28-2012", "code": "72170"}, {"date": "09-28-2012", "code": "71100"}]}]' "https://us-central1-pkcsaas-01.cloudfunctions.net/zcor_predict?target=IPF&api_key=APIKEY"
```

Replace `APIKEY` with a valid key. 

### Runtime

| Disease | Runtime (s) for 1 Patient | Runtime (s) for 1000 Patients |
|:-------:|:---------------------:|:-------------------------------------:|
|   ADRD  |        27.8825        |               1359.7784              |
|   ASD   |        11.6790        |               371.0477               |
|   ILD   |        26.5180        |               610.5329               |
|   IPF   |        12.9410        |               465.9096               |

For larger number of patients, the time perpatient is approximatley 1 second or less for most targets.

### Pricing

For information on pricing and plans, please contact our support team at [research@paraknowledge.ai](mailto:research@paraknowledge.ai). We offer various pricing models to cater to different needs, including per-use, subscription-based, and enterprise solutions.

### Additional Information

- Regular updates and maintenance schedules are posted on our [website](https://paraknowledge.ai).
- For API integration and technical queries, consult our detailed [API Documentation](#).
- Users are encouraged to report any bugs or issues via our support email.

