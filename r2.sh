# Create cloud function to process audio filess when uploaded to the bucket
yes | gcloud functions deploy safLongRunJobFunc --runtime nodejs8 --trigger-resource gs://$DEVSHELL_PROJECT_ID-upload --trigger-event google.storage.object.finalize --source=saf-longrun-job-func


# Upload Sample Audio Files for Processing
gsutil -h x-goog-meta-agentid:1234567 -h x-goog-meta-stereo:true -h x-goog-meta-agentchannel:1 -h x-goog-meta-pubsubtopicname:payload -h x-goog-meta-year:2019 -h x-goog-meta-month:11 -h x-goog-meta-day:06 -h x-goog-meta-starttime:1116 -m cp sample-audio/transcript1.wav gs://$DEVSHELL_PROJECT_ID-upload/