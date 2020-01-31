# Create cloud function to process audio filess when uploaded to the bucket
yes | gcloud functions deploy safLongRunJobFunc --runtime nodejs8 --trigger-resource gs://$DEVSHELL_PROJECT_ID-upload --trigger-event google.storage.object.finalize --source=saf-longrun-job-func
