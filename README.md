# Frontend

![https://paraknowledge.ai](./frontend.png?raw=true)


Detailed README is [here](saas/README.md)

# zcor_predit


```
curl -X POST -H "Content-Type: application/json" -d '[{"patient_id": "P28109965201", "sex": "M", "age": 89, "birth_date": "01-01-1921", "fips": "35644", "DX_record": [{"date": "12-16-2011", "code": "R09.02"}, {"date": "12-30-2011", "code": "H04.129"}, {"date": "12-30-2011", "code": "H02.109"}], "RX_record": [], "PROC_record": [{"date": "09-28-2012", "code": "71100"}]}]' "https://us-central1-pkcsaas-01.cloudfunctions.net/zcor_predict?target=IPF&api_key=7eea9f70d79c408f2b69847d6911303c"
```


```
curl -X POST -H "Content-Type: application/json" -d '[{"patient_id": "P28109965201", "sex": "M", "age": 89, "birth_date": "01-01-1921", "fips": "35644", "DX_record": [{"date": "01-08-2010", "code": "M15.9"}, {"date": "01-08-2010", "code": "I51.9"}], "RX_record": [], "PROC_record": [{"date": "12-30-2011", "code": "92014"},{"date": "09-28-2012", "code": "72170"}, {"date": "09-28-2012", "code": "71100"}]}]' "https://us-central1-pkcsaas-01.cloudfunctions.net/zcor_predict?target=IPF&api_key=7eea9f70d79c408f2b69847d6911303c"
```

```
curl -X POST -H "Content-Type: application/json" -d '[{"patient_id": "P28109965201","birth_date": "01-01-1921", "DX_record": [{"date": "01-08-2010", "code": "M15.9"}, {"date": "01-08-2010", "code": "I51.9"}], "RX_record": [], "PROC_record": []}]' "https://us-central1-pkcsaas-01.cloudfunctions.net/zcor_predict?target=IPF&api_key=7eea9f70d79c408f2b69847d6911303c"
```