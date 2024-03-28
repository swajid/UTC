# Snakemake file for running BUSCO

# Define variables
GENOME = "YNP_Eukaryota_Acidomyces_sp.fa" #file list of genomes
BUSCO_DB = "eukaryota_odb10" #none
BUSCO_LINEAGE = "eukaryota" #auto
NUM_THREADS = 1
#CONFIG_FILE: "config.yaml"

# Define all rule dependencies
#rule all:
#    input:
#        "busco_summary.txt"

# Rule to run BUSCO
rule run_busco:
    input:
        genome = GENOME
    output:
        "busco_output/"
    params:
        lineage = BUSCO_LINEAGE ,
        mode = "genome"
    threads:
        NUM_THREADS
    log:
        "logs/busco.log"
    shell:
        """
             busco -i {input.genome} -o busco_out -l {params.lineage} -m {params.mode} --cpu {threads} > {log} 2>&1
             mv busco_out/short_summary.*.txt {output.short}
             mv busco_out/full_table.*.tsv {output.full}
             mv busco_out/missing_buscos.*.tsv {output.missing}
             cp {output.short} {output.summary}
        """

