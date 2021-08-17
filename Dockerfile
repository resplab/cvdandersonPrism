FROM opencpu/base
RUN R -e 'remotes::install_github("resplab/cvdanderson")'
RUN R -e 'remotes::install_github("resplab/cvdandersonPrism")'
RUN echo "opencpu:opencpu" | chpasswd
