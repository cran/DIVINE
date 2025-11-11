#' DIVINE's table on information about comorbidities
#'
#' Information about comorbidities of patients included in the DIVINE cohort. Data was collected at hospital admission.
#'
#' @docType data
#' @keywords datasets
#' @usage data(comorbidities)
#'
#'
#' @format A data frame with 5813 rows and 37 columns
#'  \describe{
#'   \item{record_id:}{Identifier of each record. This information does not match the real data.}
#'   \item{covid_wave:}{A factor with levels `Wave 1`, `Wave 2`, `Wave 3`, and `Wave 5`. COVID-19 wave.}
#'   \item{center:}{A factor with levels `Hospital A`, `Hospital B`, `Hospital C`, `Hospital D`, and `Hospital E`. Center of admission}
#'   \item{sociofunctional:}{A factor with levels `Lives with a spouse of similar age`, `Lives with a spouse with some degree of dependency`, `Lives with a non-family caregiver`, `Lives with family. The caregiver is not their spouse`, `Lives with family without physical dependency`, `Lives alone and has no children or they are far away`, `Lives alone and has nearby children`. Sociofunctional status}
#'   \item{frailty:}{A factor with levels `No`, `PCC` and `MACA`. Is the patient a chronic complex patient (PCC) or a patient with advanced chronic disease (MACA)?}
#'   \item{barthel_score:}{Punctuation in the Barthel scale used to measure performance in activities of daily living}
#'   \item{weight:}{Weight (kg)}
#'   \item{height:}{Height (cm)}
#'   \item{body_mass_index:}{Body mass index computed as \eqn{\frac{\mbox{weight (kg)}}{\mbox{height (m)}^2}}}
#'   \item{dm:}{A factor with levels `No` and `Yes`. Diabetes mellitus Type 2}
#'   \item{type_dm:}{A factor with levels `With target organ involvement` and `Without complications`. For patients with diabetes mellitus type 2, type of disease}
#'   \item{chronic_lung_disease:}{A factor with levels `No` and `Yes`. Chronic lung disease (including COPD, asthma and obstructive sleep apnea, among others)}
#'   \item{chronic_kidney_disease:}{A factor with levels `No` and `Yes`. Severe chronic kidney disease}
#'   \item{mild_kidney_disease:}{A factor with levels `No` and `Yes`. Mild kidney disease}
#'   \item{renal_therapy:}{A factor with levels `No` and `Yes`. Is the patient currently receiving renal replacement therapy?}
#'   \item{heart_disease:}{A factor with levels `No` and `Yes`. Heart failure}
#'   \item{coronary_disease:}{A factor with levels `No` and `Yes`. Coronary heart disease}
#'   \item{myocardial_infarction:}{A factor with levels `No` and `Yes`. Has the patient ever had a heart attack?}
#'   \item{hematologic_neo:}{A factor with levels `No` and `Yes`. Haematological neoplasia}
#'   \item{hematologic_neo_type:}{A factor with levels `Leukemia`, `Lymphoma` and `Myeloma`. For patients with Haematological neoplasia, type of disease.}
#'   \item{non_metastatic_neo:}{A factor with levels `No` and `Yes`. Non-Metastatic Neoplasia}
#'   \item{metastatic_neo:}{A factor with levels `No` and `Yes`. Metastatic Neoplasia}
#'   \item{stroke_tia:}{A factor with levels `No` and `Yes`. Has the patient ever had a stroke or a transient ischemic attack?}
#'   \item{peripheral_vasculopathy:}{A factor with levels `No` and `Yes`. Peripheral artery disease}
#'   \item{dementia:}{A factor with levels `No` and `Yes`. Dementia}
#'   \item{mild_liver_disease:}{A factor with levels `No` and `Yes`. Mild liver disease}
#'   \item{severe_liver_disease:}{A factor with levels `No` and `Yes`. Severe liver disease}
#'   \item{connective_tissue_disease:}{A factor with levels `No` and `Yes`. Connective tissue disease}
#'   \item{peptic_ulcer:}{A factor with levels `No` and `Yes`. Peptic ulcer}
#'   \item{hemiplegia:}{A factor with levels `No` and `Yes`. Hemiplegia}
#'   \item{hiv:}{A factor with levels `No` and `Yes`. Human immunodeficiency virus}
#'   \item{charlson_index:}{Value of the Charlson Comorbidity Index. This index predicts the ten-year mortality for a patient given the information of their comorbid conditions}
#'   \item{hypertension:}{A factor with levels `No` and `Yes`. Hypertension}
#'   \item{dyslipidemia:}{A factor with levels `No` and `Yes`. Dyslipidemia }
#'   \item{depression:}{A factor with levels `No` and `Yes`. Depression}
#'   \item{ceiling:}{A factor with levels `Oxygen mask` (non-rebreather oxygen mask), `HFNC or NIMV` (high-flow nasal cannula or non-invasive mechanical ventilation) and `IMV and ICU admission` (invasive mechanical ventilation and acces to intensive care unit). Therapeutic ceiling of care assigned to the patient}
#'   \item{ceiling_dico:}{A factor with the dichotomization of the variable ceiling in two levels `No` (`IMV and ICU admission`) and `Yes` (`Oxygen mask` and `HFNC or NIMV`)}
#' }
#'
#' @references
#' Pallarès, N., Tebé, C., Abelenda-Alonso, G., Rombauts, A., Oriol, I., Simonetti, A. F., Rodríguez-Molinero, A., Izquierdo, E., Díaz-Brito, V., Molist, G., Gómez Melis, G., Carratalà, J., Videla, S., & MetroSud and Divine study groups (2023). Characteristics and Outcomes by Ceiling of Care of Subjects Hospitalized with COVID-19 During Four Waves of the Pandemic in a Metropolitan Area: A Multicenter Cohort Study. Infectious diseases and therapy, 12(1), 273–289. https://doi.org/10.1007/s40121-022-00705-w
#'
#'
"comorbidities"
