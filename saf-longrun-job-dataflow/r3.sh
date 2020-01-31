# Deploy a Cloud Dataflow Pipeline - Key is to forget the venv
pip install -r requirements.txt
python saflongrunjobdataflow.py --output_bigquery $DEVSHELL_PROJECT_ID:saf.transcripts --input_topic projects/$DEVSHELL_PROJECT_ID/topics/payload --region us-central1 --project $DEVSHELL_PROJECT_ID --temp_location gs://$DEVSHELL_PROJECT_ID-staging/ --staging_location gs://$DEVSHELL_PROJECT_ID-staging/ --save_main_session True --runner DataflowRunner
cd ..

# Upload Sample Audio Files for Processing
gsutil -h x-goog-meta-agentid:1234567 -h x-goog-meta-stereo:true -h x-goog-meta-agentchannel:1 -h x-goog-meta-pubsubtopicname:payload -h x-goog-meta-year:2019 -h x-goog-meta-month:11 -h x-goog-meta-day:06 -h x-goog-meta-starttime:1116 -m cp sample-audio/transcript1.wav gs://$DEVSHELL_PROJECT_ID-upload/
