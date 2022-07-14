# get Calico version
CALICO_VERSION=$(kubectl get clusterinformation default -ojsonpath='{.spec.cnxVersion}')
# set report names
CIS_REPORT_NAME='daily-cis-results'
INVENTORY_REPORT_NAME='cluster-inventory'
NETWORK_ACCESS_REPORT_NAME='cluster-network-access'
# for managed clusters you must set ELASTIC_INDEX_SUFFIX var to cluster name in the reporter pod template YAML
ELASTIC_INDEX_SUFFIX=$(kubectl get deployment -n tigera-intrusion-detection intrusion-detection-controller -ojson | \
jq -r '.spec.template.spec.containers[0].env[] | select(.name == "CLUSTER_NAME").value')


# enable if you configured audit logs for EKS cluster and uncommented policy audit reporter job
# you also need to add variable replacement in the sed command below
POLICY_AUDIT_REPORT_NAME='cluster-policy-audit'

START_TIME=$(date -d '-2 hours' -u +'%Y-%m-%dT%H:%M:%SZ')
END_TIME=$(date -u +'%Y-%m-%dT%H:%M:%SZ')

# replace variables in YAML and deploy reporter jobs
sed -e "s?<CALICO_VERSION>?$CALICO_VERSION?g" \
  -e "s?<CIS_REPORT_NAME>?$CIS_REPORT_NAME?g" \
  -e "s?<INVENTORY_REPORT_NAME>?$INVENTORY_REPORT_NAME?g" \
  -e "s?<NETWORK_ACCESS_REPORT_NAME>?$NETWORK_ACCESS_REPORT_NAME?g" \
  -e "s?<POLICY_AUDIT_REPORT_NAME>?$POLICY_AUDIT_REPORT_NAME?g" \
  -e "s?<ELASTIC_INDEX_SUFFIX>?$ELASTIC_INDEX_SUFFIX?g" \
  -e "s?<REPORT_START_TIME_UTC>?$START_TIME?g" \
  -e "s?<REPORT_END_TIME_UTC>?$END_TIME?g" \
  demo/40-compliance-reports/cluster-reporter-pods.yaml | kubectl apply -f -