# Deploy a Cloud Dataflow Pipeline
cd saf-longrun-job-dataflow
source env/bin/activate
python saflongrunjobdataflow.py --output_bigquery=$DEVSHELL_PROJECT_ID:saf.transcripts --input_topic=projects/$DEVSHELL_PROJECT_ID/topics/payload --region=us-central1 --project=$DEVSHELL_PROJECT_ID --temp_location=gs://$DEVSHELL_PROJECT_ID-staging/ --staging_location=gs://$DEVSHELL_PROJECT_ID-staging/ --runner=DataflowRunner
cd ..

# Upload Sample Audio Files for Processing
gsutil -h x-goog-meta-agentid:1234567 -h x-goog-meta-stereo:true -h x-goog-meta-agentchannel:1 -h x-goog-meta-pubsubtopicname:processAudio -h x-goog-meta-year:2019 -h x-goog-meta-month:11 -h x-goog-meta-day:06 -h x-goog-meta-starttime:1116 cp  * gs://$DEVSHELL_PROJECT_ID-upload/


# Run a DLP Job https://cloud.google.com/bigquery/docs/scan-with-dlp

