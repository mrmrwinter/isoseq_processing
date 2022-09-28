configfile: "config.yaml"

rule all:
    input:
        config["experiment_name"] + "/collapsed.gff"

rule cluster:
    input:
        config["flnc_bam"]
    output:
        config["experiment_name"] + "/unpolished.bam"
    shell:
        "isoseq3 cluster {input} {output} --verbose --use-qvs"

rule pbmm2:
    input:
        config["experiment_name"] + "/unpolished.bam",
        config["genome"],
    output:
        config["experiment_name"] + "/mapped.bam"
    shell:
        "pbmm2 align --preset ISOSEQ --sort {input[0]} {input[1]} {output}"


rule collapse:
    input:
        config["experiment_name"] + "/mapped.bam"
    output:
        config["experiment_name"] + "/collapsed.gff"
    shell:
        "isoseq3 collapse {input} {output}"
