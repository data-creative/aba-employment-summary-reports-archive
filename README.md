# ABA Employment Summary Reports Archive

An archive of Employment Summary Reports for law schools accredited by the [American Bar Association](https://www.americanbar.org/).

## Summary of Contents

### Data Transformations

Contains the results of manual and programmatic efforts to synthesize and transform raw source data into more usable formats.

#### `db/`

Contains CSV files for database consumption.

#### `api/`

Contains JSON files for client consumption.

### Original Data Sources

#### `aba-hosted/sheets/`

Contains XLS(X) files downloaded from the ABA's [Employment Summary Page](http://employmentsummary.abaquestionnaire.org/) and posted without any manual manipulation.

#### `aba-hosted/site/`

Contains CSV files populated as a result of scraping the ABA's [Schools Page](https://www.americanbar.org/groups/legal_education/resources/aba_approved_law_schools/official-guide-to-aba-approved-law-schools.html) (`schools-YYYYMMDD.csv`) and the [Employment Summary Page](http://employmentsummary.abaquestionnaire.org/) (`selectable-schools-YYYYMMDD.csv`) and posted without any manual manipulation.

#### `aba-hosted/reports/`

Intentionally kept empty because the downloadable PDF files provided by the [Employment Summary Page](http://employmentsummary.abaquestionnaire.org/) are not machine parseable. Instead see the `school-hosted/reports` directory.

#### `school-hosted/reports/`

Contains machine parseable PDF reports hosted by the respective schools. See `school-hosted/report-sources.csv` for an index containing the URL source for each annual report. This data was compiled as a result of manual search and download efforts.
