def parse_fasta(fasta_path):
    sequences = {}
    current_header = None
    current_sequence_lines = []

    with open(fasta_path, "r") as f:
        for line in f:
            line = line.strip()
            if not line:
                continue

            if line.startswith(">"):
                if current_header and current_sequence_lines:
                    sequences[current_header] = "".join(current_sequence_lines)
                current_header = line[1:]
                current_sequence_lines = []
            else:
                current_sequence_lines.append(line)

        if current_header and current_sequence_lines:
            sequences[current_header] = "".join(current_sequence_lines)
    return sequences

def merge_haplotypes(hap1_path, hap2_path, output_path):
    hap1_sequences = parse_fasta(hap1_path)
    hap2_sequences = parse_fasta(hap2_path)

    merged_output_lines = []

    common_chromosomes = sorted(
        [
            header
            for header in hap1_sequences.keys()
            if header.startswith("chr") and "_RagTag" in header
            and header in hap2_sequences
        ]
    )

    for chrom_header in common_chromosomes:
        base_chrom_name = chrom_header.split("_RagTag")[0]

        seq_a = hap1_sequences[chrom_header]
        seq_b = hap2_sequences[chrom_header]

        merged_output_lines.append(f">{base_chrom_name}_A")
        merged_output_lines.append(seq_a)
        merged_output_lines.append(f">{base_chrom_name}_B")
        merged_output_lines.append(seq_b)

    with open(output_path, "w") as f_out:
        for line in merged_output_lines:
            f_out.write(line + "\n")

# Hardcoded file paths
HAP1_FILE = "results/ragtag/hap1/ragtag.scaffold.fasta"
HAP2_FILE = "results/ragtag/hap2/ragtag.scaffold.fasta"
OUTPUT_FILE = "results/ragtag/phased_primary.fa"

# Call the function directly
merge_haplotypes(HAP1_FILE, HAP2_FILE, OUTPUT_FILE)

