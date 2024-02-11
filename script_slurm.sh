#!/bin/bash
#SBATCH --job-name=assembly_pipeline
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=8
#SBATCH --mem=32G
#SBATCH --time=24:00:00
#SBATCH --output=assembly_pipeline_%j.out
#SBATCH --error=assembly_pipeline_%j.err

# Charger le module Conda
module load conda

# Activer l'environnement Conda contenant les outils d'assemblage
conda activate mon_environnement_conda

# Chemin vers le répertoire de travail
cd /chemin/vers/votre/repertoire/de/travail

# Télécharger les données
wget https://www.ebi.ac.uk/ena/browser/download/SRR747869 -O données.fastq.gz

# Décompresser les données
gunzip données.fastq.gz

# Assemblage avec SPAdes
spades.py -1 données_R1.fastq -2 données_R2.fastq -o sortie_spades

# Évaluation de l'assemblage avec Quast
quast.py sortie_spades/contigs.fasta -o évaluation_assemblage

# Désactiver l'environnement Conda
conda deactivate