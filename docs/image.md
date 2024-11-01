---
title: Firefox Browser Container
parent: AWMS Guacamole Operator
layout: page
grand_parent: Components
---

The firefox browser container is the image provisioned by the AWMS Guacamole Operator capabilities to provide guacamole access to the browser that can then give access to the internal tools of the SDE.

The following environmental variables are exposed by the docker image:

| Name | Purpose |
| --- | --- |
| BROWSER_URL | The url that will be loaded by the browser container when loaded |
| VNC_PASSWORD | The password to connect to VNC |