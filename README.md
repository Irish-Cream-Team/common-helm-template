# Common helm chart

## How does it work?

#### The common chart is a generic helm chart, capable of deploing your microservice with k8s ersources such as: Deployments, Services, Service Acounts and ingresses.

<br></br>

### **name**

> ### _The name of your service, for example;_
>
> ```yaml
> name: "my-service123"
> ```

<br></br>

### **replicaCount**

> ### _The number of pods for your service, for example;_
>
> ```yaml
> replicaCount: 2
> ```

<br></br>

### **images**

> #### <u>PullSecrets</u>
>
> > #### _The name(s) of your docker registry pull secret(s), for example;_
> >
> > ```yaml
> > images:
> >   PullSecrets: [mypullsecret, mysecondpullsecret]
> > ```
>
> #### <u>repository</u>
>
> > #### _The name of the repository for the service's image , for example;_
> >
> > ```yaml
> > images:
> >   repository: my.registry.org/library/myimage
> > ```
>
> #### <u>tag</u>
>
> > #### _The image's tag , for example;_
> >
> > ```yaml
> > images:
> >   tag: 1.0.3-alpine
> > ```

<br></br>

### **service**

> #### <u>type</u>
>
> > #### _recives one of the following strings: "ClusterIP", "ExternalName", "LoadBalancer" and "NodePort", and sets the as the service's type. for more information about k8s service types, you can check out [k8's documentation about services](https://kubernetes.io/docs/concepts/services-networking/service/)._
> >
> > #### _for example;_
> >
> > ```yaml
> > service:
> >   type: NodePort
> > ```
> >
> > ==service.type value is not required, and will default to "ClusterIP".==
>
> #### <u>ports</u>
>
> > #### _recives an array of values for each port, the values are;_
> >
> > | key        | description                                          | Type           | additional chars | is required                    | note                                                  |
> > | ---------- | ---------------------------------------------------- | -------------- | ---------------- | ------------------------------ | ----------------------------------------------------- |
> > | name       | name of your port                                    | Alphanumerical | '-'              | yes                            | must end with an Alphanumerical character             |
> > | port       | number of published port(outside the service's pod)  | integer        | None             | yes                            | None                                                  |
> > | targetPort | number of port the your service will run on locally  | integer        | None             | no, defaults to _port_'s value | None                                                  |
> > | protocol   | the protocol your service will work on and listen to | string         | None             | no, default value is "TCP"     | has to be one of the following: "TCP","SCTP" or "UDP" |
> >
> > #### _for example:_
> >
> > ```yaml
> > service:
> >    ports:
> >        - name: http
> >        port: 80
> >        protocol: TCP
> >
> >        - name: ssh
> >        port: 443
> >        targetPort: 8443
> > ```

<br></br>

### **configmap**

> #### <u>configmaps</u>
>
> > #### _recives an array of the configmap names your service uses, for example;_
> >
> > ```yaml
> > configmap:
> >   configmaps: [first-configmap, second-configmap]
> > ```
>
> #### <u>autorestart_associated_deployments</u>
>
> > #### _a boolian that, if true, updates every pod deployment that is associated with a changed configmap. This option uses the 'wave' project for k8s,it adds an annotation named wave.pusher.com/update-on-config-change to the deployment of your service, and sets it to "true".For further information please refer to [wave's docs](https://github.com/wave-k8s/wave)_
> >
> > #### _for example;_
> >
> > ```yaml
> > configmap:
> >   autorestart_associated_deployments: false
> > ```
> >
> > <mark>configmap.autorestart_associated_deployments value is not required, and will default to "true".</mark>

<!-- <br></br>

| Key                | Type           | additional chars | note                                       |
| ------------------ | -------------- | ---------------- | ------------------------------------------ |
| name               | Alphanumerical | '-'              | must end with an Alphanumerical character. |
| replicaCount       | Integer        | None             | None                                       |
| images.PullSecrets | array          | None             | None                                       |
| images.repository  | string         | None             | None                                       |
| images.tag         | string         | None             | None                                       | -->
