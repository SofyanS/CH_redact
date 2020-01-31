# Deploy a Cloud Dataflow Pipeline - Key is to forget the venv
pip install -r requirements.txt
python saflongrunjobdataflow.py --output_bigquery $DEVSHELL_PROJECT_ID:saf.transcripts --input_topic projects/$DEVSHELL_PROJECT_ID/topics/payload --region us-central1 --project $DEVSHELL_PROJECT_ID --temp_location gs://$DEVSHELL_PROJECT_ID-staging/ --staging_location gs://$DEVSHELL_PROJECT_ID-staging/ --save_main_session True --runner DataflowRunner
cd ..