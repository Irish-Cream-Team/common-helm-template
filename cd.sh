ls -l
success_status=0
for values_files in `find $(values_path) -name '*.yaml'`; do      
    echo $values_files
    helm_count=$((helm_count+1))
    helm template common ./common -f $values_files --output-dir $values_files-common
    if (($? == 0)) ;then echo "helm templated successfuly" ;else echo "helm template failed"; fi
    kubectl apply --dry-run=server -f ./$values_files-common/common/templates/deployment.yaml
    if (($? == 0)) ;then echo "k8s manifests successfully passed dry run deployment "; ks_count=$((ks_count+1)) ;else echo "k8s manifests failed 
    during dry-run deployment" ;  fi

done
if (($ks_count == $helm_count)) ;then echo "my shit is work"  ; success_status=1  ; fi
echo "##vso[task.setvariable variable=shouldPackageRun]$success_status" 

###
helmName=` helm  package ./common | awk -F "/" '{print $(NF)}'  `
curl -k --location --request POST $(url)  -H $(Authorization)  -H 'Content-Type: text/plain'  --data-binary @$helmName


