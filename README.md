# Frontend 

## [ParaKnowledge AI](https://paraknowledge.ai)

For creating a new username and retrieving an API key, visit [ParaKnowledge AI](https://paraknowledge.ai). For support, contact [research@paraknowledge.ai](mailto:research@paraknowledge.ai).

![ParaKnowledge AI](./frontend.png?raw=true)


# `zcor_predict`

`zcor_predict` is an EHR-based predictive algorithm designed to screen for a range of disorders using electronic health records. This tool currently supports screening for the following targets:

- IPF (Idiopathic Pulmonary Fibrosis)
- ASD (Autism Spectrum Disorder)
- ADRD (Alzheimer's Disease and Related Dementia) pending

## Quickstart for `zcor_predict`

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
      "patient_id": "P28109965201",
      "predicted_risk": 0.005794344620009157,
      "probability": 0.8253881317184486
    }
  ],
  "target": "TARGET"
}
```

In this structure, `TARGET` will be either `IPF` or `ASD`, depending on the specified target in the request. Each entry in the `predictions` array corresponds to a patient's risk prediction for the specified disorder.


#### Inetrpretation

The `probability` is the probability of a patient to experience the target disorder in near future (the length of this future depends on teh model, but currently the "prediction window" is 1 year).
We recommend that for relable prediction, use decision thersholds greater than 90% or higher on this estimated probability.


---

This README and quickstart guide provides a comprehensive overview of how to use the `zcor_predict` service, including details on input and output formats, and the URL endpoint for accessing the service.

# `zcor_predict`

EHR-based predictive algorithm to screen for a range of disorders. Currently, the following targets are available:

- IPF (Idiopathic Pulmonary Fibrosis)
- ASD (Autism Spectrum Disorder)
- ADRD (Alzheimer's Disease and Related Dementias)

## Quickstart for `zcor_predict`

`zcor_predict` is deployed as a cloud function, accessible at:
```
https://us-central1-pkcsaas-01.cloudfunctions.net/zcor_predict?target=TARGET&api_key=YOUR_API_KEY
```
Replace `TARGET` with `IPF`, `ASD`, or `ADRD` and `YOUR_API_KEY` with your actual API key. The service responds to POST requests with patient data encoded as a JSON object.

### Input Format

Input should be a JSON object that consists of a list of dictionaries, each containing a single patient record. Example fields include:

- `patient_id`
- `birth_date` - in "MM-DD-YYYY" format.
- `sex` (optional) - Defaults to "F" if absent.
- `DX_record` - List of dictionaries with patient's diagnostic code (`code`) and diagnosis date (`date`).
- `RX_record` (optional) - List of dictionaries with patient's prescription code (`code`) and prescription date (`date`).
- `PROC_record` (optional) - List of dictionaries with patient's procedural code (`code`) and procedure date (`date`).

### Minimum Requirements

- Essential fields: `patient_id`, `birth_date`, and `DX_record`.
- `DX_record` must have at least 2 diagnosis codes, recorded at least 1 week apart.

### Example Inputs

#### Example 1: Single Patient

```json
[
    {
        "patient_id": "P00101606306",
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


### Example 2: Complete `curl` commands

```json
curl -X POST -H "Content-Type: application/json" -d '[{"patient_id": "P28109965201", "sex": "M", "age": 89, "birth_date": "01-01-1921", "fips": "35644", "DX_record": [{"date": "12-16-2011", "code": "R09.02"}, {"date": "12-30-2011", "code": "H04.129"}, {"date": "12-30-2011", "code": "H02.109"}], "RX_record": [], "PROC_record": [{"date": "09-28-2012", "code": "71100"}]}]' "https://us-central1-pkcsaas-01.cloudfunctions.net/zcor_predict?target=IPF&api_key=APIKEY"
```


```json
curl -X POST -H "Content-Type: application/json" -d '[{"patient_id": "P28109965201", "sex": "M", "age": 89, "birth_date": "01-01-1921", "fips": "35644", "DX_record": [{"date": "01-08-2010", "code": "M15.9"}, {"date": "01-08-2010", "code": "I51.9"}], "RX_record": [], "PROC_record": [{"date": "12-30-2011", "code": "92014"},{"date": "09-28-2012", "code": "72170"}, {"date": "09-28-2012", "code": "71100"}]}]' "https://us-central1-pkcsaas-01.cloudfunctions.net/zcor_predict?target=IPF&api_key=APIKEY"
```

```json
curl -X POST -H "Content-Type: application/json" -d '[{"patient_id": "P28109965201","birth_date": "01-01-1921", "DX_record": [{"date": "01-08-2010", "code": "M15.9"}, {"date": "01-08-2010", "code": "I51.9"}], "RX_record": [], "PROC_record": []}]' "https://us-central1-pkcsaas-01.cloudfunctions.net/zcor_predict?target=IPF&api_key=APIKEY"
```

In the above calls, replace `APIKEY` with a valid key. 



### Pricing

For information on pricing and plans, please contact our support team at [research@paraknowledge.ai](mailto:research@paraknowledge.ai). We offer various pricing models to cater to different needs, including per-use, subscription-based, and enterprise solutions.

### Additional Information

- Regular updates and maintenance schedules are posted on our [website](https://paraknowledge.ai).
- For API integration and technical queries, consult our detailed [API Documentation](#).
- Users are encouraged to report any bugs or issues via our support email.

