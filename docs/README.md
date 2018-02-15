# PURPOSE
The FunSet webserver performs Gene Ontology (GO) enrichment analysis, identifying GO terms that are statistically overrepresented in a target set with respect to a background set. The enriched terms are displayed in a 2D plot that captures the semantic similarity between terms, with the option to cluster the terms and identify a representative term for each cluster. FunSet can be used interactively or programmatically, and allows users to download the enrichment results both in tabular form and in graphical form as SVG files or in data format as JSON.

## INTERACTIVE CLIENT USAGE
* FunSet has a few required and optional parameters: 
* Organism a choice, one of: 'Homo sapiens (human)', 'Gallus gallus (chicken)', 'Canis familiaris (dog)', 'Mus musculus (mouse)', 'Rattus norvegicus (rat)', 'Caenohabditis elegans (nematode)', 'Arabidopsis thaliana (thale cress)', 'Drosophila melanogaster (fruit fly)', 'Saccharomyces cerevisiae (budding yeast)', and 'Danio rerio (zebrafish)'. (Required) 
* A set of target genes. This may be added a comma separated list or uploaded as a file. (Required)   
* A set of background genes, uploaded as a file. (Optional) If no background set is provided, FunSet will use the whole set of annotated genes for the chosen organism. Both target and background set should be submitted either as a comma-separated list in the text boxes, or as a text file (one gene per line). The accepted format is HGNC symbol.  
* A False Discovery Rate threshold. (Optional). By default, FunSet sets the FDR threshold to 0.05.  

## JSONAPI USAGE
The FunSet server is, at its core, a RESTful web service API. It allows users to not only interact with the data using the visualization interface discussed in 2b, but it also provides the raw enrichment and clustering data as JSON. The API is designed to the http://jsonapi.org/ standard to facilitate ease of interaction.

### API endpoints
The API is organized around a set of endpoints that can be invoked programmatically using a REST client, such as POSTMAN, or using any http command line tool, such as CURL. The endpoints it provides are documented below. All are accessible without login.

* **GET** `/runs/<primary key>`
  Returns the data from a previous run.

* **POST** `/runs/invoke`
  Required POST Parameters (must be in submitted using `application/x-www-form-urlencoded` encoding)
  ```
  genes=<comma-seperated-list-of-target-genes>
  background=<comma-seperated-list-of-background-genes>
  p-value=<false detection rate [0-1]> clusters=<desired number of clusters>
  organism=<3-letter organism code>
  ```
  > Acceptable 3 letter codes are: 'hsa','gga','bta','cfa','mmu','rno','cel','ath','dme','sce','eco', or 'dre'

  This will run the enrichment analysis algorithms and return JSONAPI compatible JSON data that lists all of the enriched terms. To retrieve the data for each of the terms, you must request each enriched term as given below.

* **GET** `/runs/<primary key>/recluster?clusters=<desired number of clusters>`
  Returns the same data as /runs/invoke, but only re-runs the clustering algorithm for an existing run.

* **GET** `/enrichments/<enrichment primary key>?include=term,term.parents,genes`
  Returns the enrichment term data and all submodels

* **GET** `/terms/<term primary key>`
  Returns the GO term data for the term matching the primary key

* **GET** `/genes/<gene primary key>`
  Returns the gene name for the gene matching the primary key

### API Data Schema
#### Gene
* id (int)
* name (string)

#### Term
* id (int)
* name (string)
* termid (string, official GO id)
* namespace (string)
* description (string)
* synonym (string)
* parents (many-to-many)

#### Run
* id (int)
* created (date)
* ip (string, requestor's IP)
* enrichements (one-to-many)

#### Enrichment
* id (int)
* term (ForeignKey to associated GO Term)
* pvalue (float - detection rate in sample)
* level (float - enrichment level in sample)
* semanticdissimilarityx (float - x position of term in graph scaled to 0-1)
* semanticdissimilarityy (float - y position of term in graph scaled to 0-1)
* cluster (int - the cluster to which the enriched term is assigned)
* medoid (boolean - true if this term is the metoid of its cluster)
* genes (one-to-many - all genes enriched in the sample)
