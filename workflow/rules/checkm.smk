rule all:
    input:
        "checkm/output/list.tsv"

rule run_checkm_lineage_wf:
    input:
        GENOMES_DIR = "../../test/"
    output:
        "checkm/output/qa_summary.tsv"
    params:
        output_dir = "checkm/output",
        tmp_dir = "checkm/tmp",
        threads = 90
    shell:
        """
        checkm lineage_wf --tmpdir {params.tmp_dir} -x fa -t {params.threads} \
            {input.GENOMES_DIR} {params.output_dir}

        checkm qa {params.output_dir}/lineage.ms {params.output_dir} \
            --file {output} -t {params.threads}
        """
