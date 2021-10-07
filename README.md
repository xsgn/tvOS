# tvOS
Pack of some utility applications for tvOS

# Google Domains
A daemon app to update DDNS registration managed by Google Domains.  
The UI consists of three text fields, `HOSTNAME`, `USERNAME`, `PASSWORD`.  
By filling them, the app will periodically request `https://USERNAME:PASSWORD@domains.google.com/nic/update?hostname=HOSTNAME&myip=IP` as background service.  
The query parameter will be automatically collected. 
HOSTNAME is input of `HOSTNAME` text field, 
USERNAME is input of `USERNAME` text field, 
and PASSWORD is input of `PASSWORD` text field.  
The `IP` address is resolved automatically by using `https://domains.google.com/checkip` service.  
You will find more information about google domains API service in [official site](https://support.google.com/domains/answer/6147083)
