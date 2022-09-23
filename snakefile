# https://github.com/PacificBiosciences/IsoSeq

configfile: "config.yaml"

rule all:
    input:
        config["experiment_name"] + "/collapsed.gff"

rule cluster:
    input:
        config["flnc_bam"]
    output:
        config["experiment_name"] + "unpolished.bam"
    shell:
        "isoseq cluster {input} {output} --verbose --use-qvs"

rule pbmm2:
    input:
        config["experiment_name"] + "unpolished.bam"
    output:
        config["experiment_name"] + "mapped.bam"
    shell:
        "pbmm2 align --preset ISOSEQ --sort {input} {config[genome]} {output}"


rule collapse:
    input:
        config["experiment_name"] + "mapped.bam"
    output:
        config["experiment_name"] + "collapsed.gff"
    shell:
        "isoseq3 collapse {input} {output}"

# rule :
#     input:
#         ""
#     output:
#         ""
#     shell:
#         ""

# rule :
#     input:
#         ""
#     output:
#         ""
#     shell:
#         ""

# rule :
#     input:
#         ""
#     output:
#         ""
#     shell:
#         ""