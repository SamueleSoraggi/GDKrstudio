FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies, wget, and R
RUN apt-get update && \
    apt-get install -y libssl-dev r-base gdebi-core wget libclang-dev libcurl4-openssl-dev libxml2-dev libfontconfig1-dev libharfbuzz-dev libfribidi-dev libxkbcommon-x11-0 libnss3 libgbm-dev libasound-dev ca-certificates curl libcurl4-openssl-dev && \
    rm -rf /var/lib/apt/lists/*

# Download and install RStudio Desktop
RUN wget https://download1.rstudio.org/electron/jammy/amd64/rstudio-2024.12.0-467-amd64.deb && \
    gdebi -n rstudio-2024.12.0-467-amd64.deb && \
    rm rstudio-2024.12.0-467-amd64.deb

CMD ["/usr/bin/rstudio" ,"--no-sandbox"]

#singularity run --bind /faststorage/project/testis_singlecell/Workspaces/samuele/Environments/Carl/lib/R:/faststorage/project/testis_singlecell/Workspaces/samuele/Environments/Carl/lib/R --bind /etc/pki/ca-trust/extracted/pem:/etc/pki/ca-trust/extracted/pem --bind /run/dbus/system_bus_socket:/run/dbus/system_bus_socket --bind /etc/ssl/certs:/etc/ssl/certs --env R_HOME=/faststorage/project/testis_singlecell/Workspaces/samuele/Environments/Carl/lib/R  rstudiogdk_test.sif