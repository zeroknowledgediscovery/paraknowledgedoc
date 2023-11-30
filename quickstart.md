# Quickstart

Replace APIKEY with a valid api-key obtained by emailing support.

### Single Patient IPF target

```
curl -X POST -H "Content-Type: application/json" -d '[{"patient_id": "P000012", "sex": "M", "age": 89, "birth_date": "01-01-1921", "fips": "35644", "DX_record": [{"date": "01-05-2012", "code": "G35"}, {"date": "02-02-2012", "code": "H35.359"}, {"date": "03-29-2012", "code": "G35"}, {"date": "04-05-2012", "code": "R94.09"}, {"date": "04-05-2012", "code": "G35"}, {"date": "06-21-2012", "code": "G35"}], "RX_record": [], "PROC_record": [{"date": "03-29-2012", "code": "72170"}]}]' "https://us-central1-pkcsaas-01.cloudfunctions.net/zcor_predict?target=IPF&api_key=APIKEY"

```



### Single Patient IPF target with high speed execution (in memory model)

```
curl -X POST -H "Content-Type: application/json" -d '[{"patient_id": "P000012", "sex": "M", "age": 89, "birth_date": "01-01-1921", "fips": "35644", "DX_record": [{"date": "01-05-2012", "code": "G35"}, {"date": "02-02-2012", "code": "H35.359"}, {"date": "03-29-2012", "code": "G35"}, {"date": "04-05-2012", "code": "R94.09"}, {"date": "04-05-2012", "code": "G35"}, {"date": "06-21-2012", "code": "G35"}], "RX_record": [], "PROC_record": [{"date": "03-29-2012", "code": "72170"}]}]' "https://us-central1-pkcsaas-01.cloudfunctions.net/zcor_predict_fast?target=IPF&api_key=APIKEY"

```


### Single Patient ILD target

```
curl -X POST -H "Content-Type: application/json" -d '[{"patient_id": "P000012", "sex": "M", "age": 89, "birth_date": "01-01-1921", "fips": "35644", "DX_record": [{"date": "01-05-2012", "code": "G35"}, {"date": "02-02-2012", "code": "H35.359"}, {"date": "03-29-2012", "code": "G35"}, {"date": "04-05-2012", "code": "R94.09"}, {"date": "04-05-2012", "code": "G35"}, {"date": "06-21-2012", "code": "G35"}], "RX_record": [], "PROC_record": [{"date": "03-29-2012", "code": "72170"}]}]' "https://us-central1-pkcsaas-01.cloudfunctions.net/zcor_predict?target=ILD&api_key=APIKEY"

```

### Multiple patient data in file

```
curl -s -X POST -H "Content-Type: application/json" -d @sampledata/patients_10.json "https://us-central1-pkcsaas-01.cloudfunctions.net/zcor_predict?target=IPF&api_key=APIKEY"
```


### Single Patient SISA target

```
curl -X POST -H "Content-Type: application/json" -d '[{"patient_id": "P000012", "sex": "M", "age": 89, "birth_date": "01-01-1921", "fips": "35644", "DX_record": [{"date": "01-05-2012", "code": "G35"}, {"date": "02-02-2012", "code": "H35.359"}, {"date": "03-29-2012", "code": "G35"}, {"date": "04-05-2012", "code": "R94.09"}, {"date": "04-05-2012", "code": "G35"}, {"date": "06-21-2012", "code": "G35"}], "RX_record": [], "PROC_record": [{"date": "03-29-2012", "code": "72170"}]}]' "https://us-central1-pkcsaas-01.cloudfunctions.net/zcor_predict?target=SISA&api_key=APIKEY"

```



### Emergenet

```
curl -X POST https://us-central1-pkcsaas-01.cloudfunctions.net/emergenet_predict?api_key=APIKEY -H "Content-Type: application/json" -d @"sampledata/alberta.json" 
```


### NERO

Also can be triggered from the landing page navigation button.

```
curl -X POST -F "file=@FILEPATH" "https://us-central1-pkcsaas-01.cloudfunctions.net/nero?api_key=APIKEY"

```

