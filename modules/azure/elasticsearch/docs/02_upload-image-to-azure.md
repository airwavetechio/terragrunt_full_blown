## Upload Image to Azure and prep it for usage
* Once you have the VHD file, navigate to `Storage Accounts` and choose a Storage Account that matches the region you are going to provision to. If one doesn't exist, just create it. 
![es](./assets/es-16.png)

* Select `Containers` and click on the container shown. If a container doesn't exist, just create it. 
![es](./assets/es-17.png)

* Upload the file as a `Page Blob`
![es](./assets/es-18.png)

* Navigate to `Images` in the Azure console and create an Image. Be mindful of the various options shown in the image below. 
![es](./assets/es-19.png)

## Adding the Image to a Shared Gallery
* Click on the image and select `Clone to a VM Image`
https://azure.microsoft.com/en-us/resources/templates/sig-create/
![es](./assets/es-24.png)
* Be mindful for the `Resource Group`, `Version number` and `End of life date`
![es](./assets/es-25.png)
* Create a new Azure Compute Gallery
![es](./assets/es-26.png)
![es](./assets/es-27.png)
* Create a new VM Image Definition
![es](./assets/es-28.png)
* Fill in the `VM image definition name`, `Publisher`, `Offer` and `SKU` as shown in the image
![es](./assets/es-29.png)
* Click on `Next: Replication`. Check on the `Default Storage sku`, `Default Replica Count` and add `Target regions` to the regions you want this to be available in. 
![es](./assets/es-30.png)
* Click on `Next: Encryption`
![es](./assets/es-31.png)
* Click on `Review + create` and then `Create`
![es](./assets/es-32.png)

## Adding permissions to the Shared Image
* In the Azure console, navigate to `Azure Compute Galleries > elasticsearc_6_4 > Access control (IAM)`
![es](./assets/es-33.png)
* Click on `Add role assignment`
![es](./assets/es-34.png)
* Click on `Owner` so it is selected
![es](./assets/es-35.png)
* Click on `Members` and `Select members`
![es](./assets/es-36.png)
* Add groups and people that you wish to give access to and click `Select`
![es](./assets/es-37.png)
* Review + assign

## Get the Resource ID of the Image to use for Terraform
* Once that task is finished, goto the `Azure computer galleries > elasticsearch_6_4 > click on  Definition 'elasticsearch_6_4'`
![es](./assets/es-38.png)
* Click on `Properties` and grab the `Resource ID`. This is what you will need in Terraform. 
![es](./assets/es-39.png)

