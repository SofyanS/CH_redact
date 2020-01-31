# Create a GCS bucket
gsutil mb -l us-central1 gs://$DEVSHELL_PROJECT_ID-upload/

# Create a Cloud Storage Bucket for Staging Contents
gsutil mb -l us-central1 gs://$DEVSHELL_PROJECT_ID-staging/
touch tmp.txt
gsutil cp tmp.txt gs://$DEVSHELL_PROJECT_ID-staging/DFaudio/tmp.txt

# Create Cloud Pub/Sub Topic
gcloud pubsub topics create payload

# Create BQ Dataset
bq mk saf
bq mk --table $DEVSHELL_PROJECT_ID:saf.transcripts bigquery/schema.json
