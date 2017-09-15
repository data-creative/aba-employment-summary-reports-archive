# ABA Employment Summary Reports Archive

An archive of annual Employment Summary Reports for law schools accredited by the [American Bar Association](https://www.americanbar.org/).

## Contents

### Original Data Sources

#### `downloads/aba-hosted-sheets/`

Contains XLS(X) files downloaded from the ABA's [Employment Summary Page](http://employmentsummary.abaquestionnaire.org/) posted without any manual manipulation.

Each file comprises only one sheet, which has been converted without manual manipulation to CSV format (see the `db/` directory).

#### `downloads/aba-hosted-reports/`

Contains PDF files downloaded from the ABA's [Employment Summary Page](http://employmentsummary.abaquestionnaire.org/).

#### `downloads/school-hosted-reports/`

Contains PDF reports hosted by the respective schools. See `db/reports.csv` for an index containing the URL source for each report. This data was compiled as a result of manual search and download efforts.

### Data Derivations

Contains the results of mostly-programmatic efforts to synthesize and improve programmatic usability of original data sources.

#### `db/`

Contains CSV files for database consumption.

Some CSV files were populated as a result of scraping the ABA's [Schools Page](https://www.americanbar.org/groups/legal_education/resources/aba_approved_law_schools/official-guide-to-aba-approved-law-schools.html) (`schools-YYYYMMDD.csv`) and the [Employment Summary Page](http://employmentsummary.abaquestionnaire.org/) (`selectable-schools-YYYYMMDD.csv`) and posted without any manual manipulation.

#### `api/`

Contains JSON files for client application consumption.
