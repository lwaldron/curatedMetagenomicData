[![Support Site Activity](https://bioconductor.org/shields/posts/curatedMetagenomicData.svg)](https://support.bioconductor.org/t/curatedmetagenomicdata/)
[![Build Results](https://bioconductor.org/shields/build/devel/data-experiment/curatedMetagenomicData.svg)](https://bioconductor.org/checkResults/devel/data-experiment-LATEST/curatedMetagenomicData/)
[![Travis-CI Build Status](https://travis-ci.org/waldronlab/curatedMetagenomicData.svg?branch=master)](https://travis-ci.org/waldronlab/curatedMetagenomicData)
[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/waldronlab/curatedMetagenomicData?branch=master&svg=true)](https://ci.appveyor.com/project/schifferl/curatedmetagenomicdata-o9eib)
[![Coverage Status](https://img.shields.io/codecov/c/github/waldronlab/curatedMetagenomicData/master.svg)](https://codecov.io/github/waldronlab/curatedMetagenomicData?branch=master)
[![Subversion Commits](https://bioconductor.org/shields/commits/data-experiment/curatedMetagenomicData.svg)](https://bioconductor.org/packages/devel/data/experiment/html/curatedMetagenomicData.html#svn_source)

# curatedMetagenomicData

*curatedMetagenomicData* is a *Bioconductor* package using *ExperimentHub* to access 
a large number (n ≈ 3000) of human microbiome samples gathered from various sources.

See quick-start directions on the wiki [here](https://github.com/waldronlab/curatedMetagenomicData/wiki).

## Accessing Data through R/Bioconductor

*curatedMetagenomicData* and its related data can be accessed through *R* using *Bioconductor* & *ExperimentHub*. To install the necessary software:

1. Install *R* and *Bioconductor* according to instructions at [www.bioconductor.org/install](www.bioconductor.org/install).

2. From the *R* prompt, install *curatedMetagenomicData*:
```
BiocInstaller::biocLite("curatedMetagenomicData")
```

Then you can access datasets through *R* like this:

```{r}
library(curatedMetagenomicData)
eset = LomanNJ_2013_Hi.metaphlan_bugs_list.stool()
```

From the resulting *ExpressionSet* object you can extract metagenomic data with `exprs( eset )`, participant and sequencing information using `pData( eset )`, and study information using `experimentData( eset )`. 

The Metaphlan bugs datasets can be converted to *phyloseq* objects for use with the excellent [phyloseq](bioconductor.org/packages/phyloseq) Bioconductor package (see ?ExpressionSet2phyloseq) for more details on this conversion:

```
ExpressionSet2phyloseq( eset, simplify=TRUE, relab=FALSE )
```

Usage instructions beyond these basic steps are available in the package [vignette](https://bioconductor.org/packages/release/data/experiment/vignettes/curatedMetagenomicData/inst/doc/curatedMetagenomicData.html). A list of all datasets is available in the [Reference Manual](http://bioconductor.org/packages/release/data/experiment/manuals/curatedMetagenomicData/man/curatedMetagenomicData.pdf).

## Accessing Data From the Command Line

You must install *R*, *Bioconductor*, and *curatedMetagenomicData* using the instructions above. Additionally, you must install the *docopt* package from 
within *R*:
```
BiocInstaller::biocLite("docopt")
```

Then:

1. Download the [curatedMetagenomicData shell script](https://raw.githubusercontent.com/waldronlab/curatedMetagenomicData/master/inst/commandline/curatedMetagenomicData). 

2. Make sure it has executable permissions:
```
chmod a+x curatedMetagenomicData
```

3. Make sure the R executable at the top of the script is correct (by default `/usr/bin/Rscript`). Check where your `Rscript` is installed by `which Rscript`.

4. Place the *curatedMetagenomicData* file somewhere in your PATH, or invoke it using `./curatedMetagenomicData`. Use `./curatedMetagenomicData -h`to see its help.

## Adding New Data

The following steps describe the process needed to add new data to the package; 
these steps are not of any consequence to the end user and should only concern the
developers of this package.

### Project Source

The source of `curatedMetagenomicData` is hosted on GitHub and is updated 
periodically. As such, the addition of any new dataset should begin with the 
most up to date project source. This is accomplished by cloning the repository 
from GitHub as a new RStudio project (or doing a pull if the project source has 
been cloned previously). Once cloned, the source should be built and reloaded, a
button is found in the build pane of RStudio. This step must be successfully 
completed before moving on given that developer functions have relative paths 
and it will be necessary to view package contents during the process of adding a
new dataset.

### Helper Functions

There are two helper functions to aid in adding new datasets to the package. The
first, `load_suggests()`, is used to load all the suggested packages listed in 
the `DESCRIPTION` file. If a package is not installed, the function will 
download and install it using only the `base` and `utils` packages. This choice 
is intentional and seeks to avoid the use of dependencies beyond the packages 
that ship with R. The second function, `source_scripts()`, provides a mechanism 
to quickly load all of the functions used in processing `*.tar.gz` files into 
the final `ExpressionSet` objects. The functions are not exported and must be 
used as follows:

```
curatedMetagenomicData:::load_suggests()
curatedMetagenomicData:::source_scripts()
```

### Input Files
    
Input files are `*.tar.gz` files sourced from `HUMAnN2` & `MetaPhlAn2` outputs 
with the expectation of a specific directory structure. An example directory 
structure from which an actual dataset was created is shown below. The name of 
each directory is used in the creation of its related data product, with `*.tsv`
(tab separated values) files representing each sample. Additionally, a 
`metadata.tsv` file containing phenotype data is expected in the `metadata` 
directory. The `*.tar.gz` of the directory structure shown below (i.e. 
`LomanNJ_2013_Mi.tar.gz`) would represent the input file needed to create 
`ExpressionSet` objects.

```
LomanNJ_2013_Mi/
├── genefamilies_relab
│   ├── OBK1122.tsv
│   ├── OBK1196.tsv
│   ├── OBK1253.tsv
│   ├── OBK2535.tsv
│   ├── OBK2638.tsv
│   ├── OBK2723.tsv
│   ├── OBK4096.tsv
│   ├── OBK4328.tsv
│   └── OBK4961.tsv
├── marker_abundance
│   ├── OBK1122.tsv
│   ├── OBK1196.tsv
│   ├── OBK1253.tsv
│   ├── OBK2535.tsv
│   ├── OBK2638.tsv
│   ├── OBK2723.tsv
│   ├── OBK4096.tsv
│   ├── OBK4328.tsv
│   └── OBK4961.tsv
├── marker_presence
│   ├── OBK1122.tsv
│   ├── OBK1196.tsv
│   ├── OBK1253.tsv
│   ├── OBK2535.tsv
│   ├── OBK2638.tsv
│   ├── OBK2723.tsv
│   ├── OBK4096.tsv
│   ├── OBK4328.tsv
│   └── OBK4961.tsv
├── metadata
│   └── metadata.tsv
├── metaphlan_bugs_list
│   ├── OBK1122.tsv
│   ├── OBK1196.tsv
│   ├── OBK1253.tsv
│   ├── OBK2535.tsv
│   ├── OBK2638.tsv
│   ├── OBK2723.tsv
│   ├── OBK4096.tsv
│   ├── OBK4328.tsv
│   └── OBK4961.tsv
├── pathabundance_relab
│   ├── OBK1122.tsv
│   ├── OBK1196.tsv
│   ├── OBK1253.tsv
│   ├── OBK2535.tsv
│   ├── OBK2638.tsv
│   ├── OBK2723.tsv
│   ├── OBK4096.tsv
│   ├── OBK4328.tsv
│   └── OBK4961.tsv
└── pathcoverage
    ├── OBK1122.tsv
    ├── OBK1196.tsv
    ├── OBK1253.tsv
    ├── OBK2535.tsv
    ├── OBK2638.tsv
    ├── OBK2723.tsv
    ├── OBK4096.tsv
    ├── OBK4328.tsv
    └── OBK4961.tsv
```

### `ExpressionSet` Objects

`ExpressionSet` objects are created, serialized, and saved using the `make_data()` 
function. A single argument, `tar_gz_file`, representing the path of `*.tar.gz` 
file is passed to the function. For example:

```{r}
make_data("~/LomanNJ_2013_Mi.tar.gz")
```

Internally the `make_data()` function will unzip the file into the `./tmp` 
directory of the package and read in the sample & experiment data. The process 
happens in parallel and will take minutes to hours depending on CPU cores & the 
number of samples within the dataset. Once read in, the samples and metadata and 
processed and coerced into `ExpressionSet` objects. These objects are then split 
into smaller `ExpressionSet` objects by bodysite and saved as compressed `Rda` 
files in the `./data` directory of the package.

### `ExpressionSet` Documentation

`ExpressionSet` objects are documented using the `make_documentation()` 
function, which does not require any arguments. This is because the 
`make_data()` function produced `ExpressionSet` objects for each dataset in the 
`./data` directory. Following from this assumption, dataset specific `*.Rd` man 
pages are created using `roxygen2` in two steps. First, the 
`make_documentation()` function loads each `ExpressionSet` object and serializes
information for the man page. Second, the serialized information is used to 
write a `*.R` file of roxygen comments for each dataset & data type. Finally, as
`roxygen2` is run (e.g. `devtools::document()`), the roxygen comments become 
`*.Rd` man pages to document each `ExpressionSet` object.

### `ExperimentHub` Metadata

As per the `ExperimentHub` specifications, a `metadata.csv` file is needed to 
document each data resource the package provides; this file is created or 
augmented using the `make_metadata()` function. Much like the 
`make_documentation()` function, no arguments are required because the package 
directory structure can be assumed. Internally the function is also similar to 
the `make_documentation()` function in that it reads in each `ExpressionSet` 
object and serialized the information as required in the `metadata.csv` file. In
the final step of the `make_metadata()` function a line for each `ExpressionSet`
is written to the `metadata.csv` file. It is important to note that this process
does not overwrite the existing file and that is the desired behavior. In such a
way, new resources can be added to the package without any changes to the older 
resources.

### `ExperimentHub` Upload

Finally, as a convenience, a function, `make_upload()`, has been added to the 
package to make the uploading of resources to AWS S3 as simple as issuing a 
shell command. Again, the function requires no arguments, as directory structure
is established within the package. The `make_upload()` function itself creates a
shell script, `upload2AWS.sh`, in the `./exec` directory. When run, the script
uploads all the objects in the `./data` directory to the AWS S3 bucket provided 
by `BioConductor`. However, please note that it is necessary to have 
authorization credentials for the AWS S3 bucket in order for the upload to work.
