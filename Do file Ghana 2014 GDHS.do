//Set working directory

cd  "C:\Users\kjacob\OneDrive - Kemri Wellcome Trust\Reviews\Caroline Puobebe\Ghana 2014"

//2014 GDHS data 

log using caroAnalysis.log, replace

use "C:\Users\kjacob\OneDrive - Kemri Wellcome Trust\Reviews\Caroline Puobebe\Ghana 2014\ghbr72dt\GHBR72FL.DTA", clear


* rename variables
 ren v006 Month_intvw
 ren v007 Year_intvw
 ren v010 RBirth_Year
 ren v012 RCurrent_Age
 ren v013 RAge_group
 ren v106 Education_level
 ren v130 Religion
 ren v501 marital_status
 ren b4 Sex_of_child
 ren m70 Check_2mths
 ren b1 Cmonth_birth
 ren b2 Cyear_birth
 ren m15 Cplc_delivery
 ren h0 rcvd_OPV0
 ren h2 rcvd_BCG
 ren h3 rcvd_DTP1
 ren h4 rcvd_OPV1
 ren h5 rcvd_DTP2
 ren h6 rcvd_OPV2
 ren h7 rcvd_DTP3
 ren h8 rcvd_OPV3
 ren h9 rcvd_MEASLES
 ren v190 wealth_index
 ren h1 Health_card
 ren v467d Dstnc_hfcilty
 ren ye rcvd_yellow
 
 *generate age of the child in months (date of interview-date of birth of child) 
 
 gen agemonth= v008-b3
 
  *generate alive children children aged 12-23 months
 gen C_age=0
 replace C_age= 1 if agemonth >=12 & agemonth<=23
 
 *drop children <12 &>23 months
 drop if C_age ==0
 
 * drop dead children (remain with living children aged 12-23 months)
 drop if b5==0
 
******************************************************************************
*****************************************************************************
*tell Stata the weight (using pweights for robust standard errors), cluster (psu), and strata:
gen pweight=v005/1000000

egen strata = group(v024 v025), label

svyset [pweight=pweight], psu(v021) strata(strata)


*****Generatng vaccinated or not by antigen**
gen bcg_vac=.
replace bcg_vac=0 if (rcvd_BCG==0 | rcvd_BCG==3 | rcvd_BCG==8 |rcvd_BCG==9) 
replace bcg_vac=1 if (rcvd_BCG==1|rcvd_BCG==2)
label define bcg_vac 0 "not vaccinated"  1 "vaccinated",modify
label values bcg_vac bcg_vac
tab bcg_vac




gen dpt1_vac=.
replace dpt1_vac=0 if (rcvd_DTP1==0 | rcvd_DTP1==3 | rcvd_DTP1==8 |rcvd_DTP1==9)
replace dpt1_vac=1 if (rcvd_DTP1==1|rcvd_DTP1==2)
label define dpt1_vac 0 "not vaccinated"  1 "vaccinated",modify
label values dpt1_vac dpt1_vac

tab dpt1_vac

gen dpt2_vac=.
replace dpt2_vac=0 if (rcvd_DTP2==0 | rcvd_DTP2==3 | rcvd_DTP2==8 |rcvd_DTP2==9)
replace dpt2_vac=1 if (rcvd_DTP2==1|rcvd_DTP2==2)
label define dpt2_vac 0 "not vaccinated"  1 "vaccinated",modify
label values dpt2_vac dpt2_vac
tab dpt2_vac

gen dpt3_vac=.
replace dpt3_vac=0 if (rcvd_DTP3==0 | rcvd_DTP3==3 | rcvd_DTP3==8 |rcvd_DTP3==9)
replace dpt3_vac=1 if (rcvd_DTP3==1|rcvd_DTP3==2)
label define dpt3_vac 0 "not vaccinated"  1 "vaccinated",modify
label values dpt3_vac dpt3_vac
tab dpt3_vac

gen opv0_vac=.
replace opv0_vac=0 if ( rcvd_OPV0==0| rcvd_OPV0==3| rcvd_OPV0==8| rcvd_OPV0==9)
replace opv0_vac=1 if (rcvd_OPV0==1| rcvd_OPV0==2)
label define opv0_vac 0 "not vaccinated"  1 "vaccinated",modify
label values opv0_vac opv0_vac
tab opv0_vac

gen opv1_vac=.
replace opv1_vac=0 if (rcvd_OPV1==0| rcvd_OPV1==3| rcvd_OPV1==8| rcvd_OPV1==9)
replace opv1_vac=1 if (rcvd_OPV1==1| rcvd_OPV1==2)
label define opv1_vac 0 "not vaccinated"  1 "vaccinated",modify
label values opv1_vac opv1_vac
tab opv1_vac

gen opv2_vac=.
replace opv2_vac=0 if (rcvd_OPV2==0| rcvd_OPV2==3| rcvd_OPV2==8| rcvd_OPV2==9)
replace opv2_vac=1 if (rcvd_OPV2==1| rcvd_OPV2==2)
label define opv2_vac 0 "not vaccinated"  1 "vaccinated",modify
label values opv2_vac opv2_vac
tab opv2_vac

gen opv3_vac=.
replace opv3_vac=0 if ( rcvd_OPV3==0| rcvd_OPV3==3| ///
rcvd_OPV3==8| rcvd_OPV3==9)
replace opv3_vac=1 if (rcvd_OPV3==1| rcvd_OPV3==2)
label define opv3_vac 0 "not vaccinated"  1 "vaccinated",modify
label values opv3_vac opv3_vac
tab opv3_vac

gen measles_vac=.
replace measles_vac=0 if (rcvd_MEASLES==0| ///
rcvd_MEASLES==3|rcvd_MEASLES==8|rcvd_MEASLES==9)
replace measles_vac=1 if (rcvd_MEASLES==1|rcvd_MEASLES==2)
label define measles_vac 0 "not vaccinated"  1 "vaccinated",modify
label values measles_vac measles_vac
tab measles_vac

gen yellow_vac=.
replace yellow_vac=0 if (rcvd_yellow==0 | rcvd_yellow==3 | rcvd_yellow==8 | rcvd_yellow==9)
replace yellow_vac=1 if (rcvd_yellow==1 | rcvd_yellow==2)
label define yellow_vac 0 "not vaccinated"  1 "vaccinated", modify
label values yellow_vac yellow_vac



******generating immunization status for only BCG, OPV1, OPV2, OPV3, DPT1, DPT2, DPT3 and Measles
gen immunization_status1=.
replace immunization_status1=0 if (bcg_vac==0& dpt1_vac==0& dpt2_vac==0& dpt3_vac==0& opv1_vac==0& opv2_vac==0& opv3_vac==0& measles_vac==0)
replace immunization_status1=1 if (bcg_vac==1|dpt1_vac==1| dpt2_vac==1|dpt3_vac==1|opv1_vac==1|opv2_vac==1|opv3_vac==1|measles_vac==1)
replace immunization_status1=2 if (bcg_vac==1 & dpt1_vac==1& dpt2_vac==1& dpt3_vac==1& opv1_vac==1& opv2_vac==1& opv3_vac==1& measles_vac==1)
label define immunization_status1 0 "not immunized"  1 "partially immunized" 2 "fully immunized", modify
label values immunization_status1 immunization_status1
tab immunization_status1


*****generate non- or under-immunized and fully immunized

gen fic=.
replace fic=0 if (immunization_status1==0 | immunization_status1==1)
replace fic=1 if (immunization_status1==2)
labe define fic 0 "non- or under-immunized" 1 "fully immunized"
label values fic fic
tab fic


*****vaccination coverage for each vaccine

//Table 2 - Distribution of vaccination coverage by vaccine type.
tab bcg_vac
svy: prop bcg_vac 

tab dpt1_vac
svy: prop dpt1_vac 

tab dpt2_vac
svy: prop dpt2_vac 

tab dpt3_vac
svy: prop dpt3_vac 

tab opv1_vac
svy: prop opv1_vac 

tab opv2_vac
svy: prop opv2_vac 

tab opv3_vac
svy: prop opv3_vac 

tab measles_vac
svy: prop measles_vac 

******received all 8 vaccines
tab immunization_status1 [aweight=pweight] //- Not immunized, partially immunized and fic

tab fic
svy: prop fic  //Binary 

*****Independent factors
** 1. Child Sex
tab Sex_of_child [aweight=pweight]

***2. Mother's age group
 gen mthrage_grp=.
 replace mthrage_grp=0 if (RAge_group==1 | RAge_group==2)
 replace mthrage_grp=1 if (RAge_group==3)
 replace mthrage_grp=2 if (RAge_group==4 | RAge_group==5 | RAge_group==6 | RAge_group==7)
 label define mthrage_grp 0 "<=24" 1 "25-29" 2 ">=30"
 label values mthrage_grp mthrage_grp
 
 ***3. Mother's marital status
 gen mothr_maritalstats=.
 replace mothr_maritalstats=0 if (marital_status==0)
 replace mothr_maritalstats=1 if (marital_status==1 | marital_status==2)
 replace mothr_maritalstats=2 if (marital_status==3 | marital_status==4 | marital_status==5)
 label define  mothr_maritalstats 0 "Never married" 1 "Currently married" 2 "Formerly married"
 label values  mothr_maritalstats   mothr_maritalstats
 
 ***4. Mother's education level
gen mothr_education=.
replace mothr_education=0 if (Education_level==0)
replace mothr_education=1 if (Education_level==1)
replace mothr_education=2 if (Education_level==2 | Education_level==3)
label define mothr_education 0 "No education" 1 "Primary" 2 "Secondary/Higher"
label values mothr_education mothr_education


***5. socio-economic status/wealth index
 gen economic_status=.
 replace economic_status=0 if (wealth_index==1 | wealth_index==2)
 replace economic_status=1 if (wealth_index==3)
 replace economic_status=2 if (wealth_index==4| wealth_index==5)
 label define economic_status 0 "Poor" 1 "Middle" 2 "Rich"
 label values economic_status economic_status
 
 ***6. generate Rural residence  
 gen rural_residence=.
 replace rural_residence=0 if (v025==1)
 replace rural_residence=1 if (v025==2)
 label define rural_residence 0 "No/urban" 1 "yes/rural", modify
 label values rural_residence rural_residence
 
 ***7. Child' place of birth/delivery
 gen place_birth=.
 replace place_birth=0 if (Cplc_delivery==11 | Cplc_delivery==12 | Cplc_delivery==96)
 replace place_birth=1 if (Cplc_delivery==21 | Cplc_delivery==22 | Cplc_delivery==23 | Cplc_delivery==26 | Cplc_delivery==31 | Cplc_delivery==33)
 label define place_birth 0 "Home" 1 "Hospital/Health Facilities", modify
 label values place_birth place_birth
 
***8. child checkup within two months 
 gen check_2mths=.
 replace check_2mths=0 if (Check_2mths==0)
 replace check_2mths=1 if (Check_2mths==1)
 label define check_2mths 0 "Not checked " 1 "checked within 2months", modify
 label values check_2mths check_2mths
 ***9. Distance to health facility (big problem/not a big problem)
 gen distc_a_problm=.
 replace distc_a_problm=0 if Dstnc_hfcilty==2
 replace distc_a_problm=1 if Dstnc_hfcilty==1
 label define distc_a_problm 0 "no" 1 "yes"
 label values distc_a_problm distc_a_problm
 
 ***10. Birth order
gen birth_order=.
replace birth_order=0 if (bord==1)
replace birth_order=1 if (bord==2 | bord==3)
replace birth_order=2 if (bord>=4)
label define birth_order 0 "1" 1 "2/3" 2 ">=4"
label values birth_order birth_order
 
 ***13. generating with and without vaccination card
gen healthcard=.
replace healthcard=0 if (Health_card==0| Health_card==2| Health_card==3)
replace healthcard=1 if (Health_card==1)
label define healthcard 0 "without healthcard" 1 "with health card"
label values healthcard healthcard

tab healthcard [aweight=pweight]



***************************************************************************
***************************************************************************

//Inequality analysis

//Concentartion indices
//1. BCG
conindex bcg_vac, rankvar(v191) bounded limits(0 1) wagstaff

//2. DPT1
conindex dpt1_vac, rankvar(v191) bounded limits(0 1) wagstaff

//3. DPT2
conindex dpt2_vac, rankvar(v191) bounded limits(0 1) wagstaff

//4. DPT3
conindex dpt3_vac, rankvar(v191) bounded limits(0 1) wagstaff


//5. OPV1
conindex opv1_vac, rankvar(v191) bounded limits(0 1) wagstaff

//6. OPV2
conindex opv2_vac, rankvar(v191) bounded limits(0 1) wagstaff

//7. OPV3
conindex opv3_vac, rankvar(v191) bounded limits(0 1) wagstaff

//8. Measles

conindex measles_vac, rankvar(v191) bounded limits(0 1) wagstaff

///High to low ratio
tab bcg_vac wealth_index [aw=pweight], col

tab dpt1_vac wealth_index [aw=pweight], col  

tab dpt2_vac wealth_index [aw=pweight], col  

tab dpt3_vac wealth_index [aw=pweight], col 


tab opv1_vac wealth_index [aw=pweight], col 

tab opv2_vac wealth_index [aw=pweight], col

tab opv3_vac wealth_index [aw=pweight], col


tab measles_vac wealth_index [aw=pweight], col


tab fic wealth_index [aw=pweight], col

///Table 3 - Distribution of Fully immunization coverage by selected factors

tab fic Sex_of_child, col
svy: prop fic, over(Sex_of_child)
 
tab fic mthrage_grp, col 
svy: prop fic, over(mthrage_grp)

 
tab fic mothr_maritalstats, col 
svy: prop fic, over(mothr_maritalstats)
 
tab fic mothr_education, col 
svy: prop fic, over(mothr_education)
 
tab fic economic_status, col 
svy: prop fic, over(economic_status)

 
tab fic rural_residence, col 
svy: prop fic, over(rural_residence)

 
tab fic place_birth, col
svy: prop fic, over(place_birth)
 
 
tab fic check_2mths, col
svy: prop fic, over(check_2mths)
 
 
tab fic birth_order, col
svy: prop fic, over(birth_order)

//Overall FIC - Fully immunized child
conindex fic, rankvar(v191) bounded limits(0 1) wagstaff

gen fic_2014=fic

label define fic_2014 0 "Non/unerimmunised" 1 "Fully immunised", modify
label values fic_2014 fic_2014


//Concentration curves
//All 8 vaccine doses NB - All lie on the line of equality
clorenz bcg_vac dpt1_vac dpt2_vac dpt3_vac opv1_vac opv2_vac opv3_vac measles_vac, rank(v191)


clorenz bcg_vac, rank(v191)

clorenz dpt3_vac, rank(v191)

clorenz measles_vac, rank(v191)

clorenz fic, rank(v191)

gen bcg_2014=bcg_vac
gen dpt1_2014=dpt1_vac
gen dpt2_2014=dpt2_vac
gen dpt3_2014=dpt3_vac
gen opv1_2014=opv1_vac
gen opv2_2014=opv2_vac
gen opv3_2014=opv3_vac
gen measles_2014=measles_vac

//Combine graphs
graph combine bcg.gph dpt3.gph Measles.gph fic.gph





***Sub-group inequality analysis
Sex_of_child
recode Sex_of_child (2=0 "Female") (1=1 "Male"), gen(sex_of_child) 

tab fic sex_of_child [aw=pweight], col 
conindex fic if sex_of_child==0, rankvar(wscore) bounded limits(0 1) wagstaff 

conindex fic if sex_of_child==1, rankvar(v191) bounded limits(0 1) wagstaff 


tab fic mothr_education [aw=pweight], col 
conindex fic if mothr_education==0, rankvar(v191) bounded limits(0 1) wagstaff 

conindex fic if mothr_education==1, rankvar(v191) bounded limits(0 1) wagstaff 

conindex fic if mothr_education==2, rankvar(v191) bounded limits(0 1) wagstaff 


tab fic mthrage_grp [aw=pweight], col 
conindex fic if mthrage_grp==0, rankvar(v191) bounded limits(0 1) wagstaff 

conindex fic if mthrage_grp==1, rankvar(v191) bounded limits(0 1) wagstaff 

conindex fic if mthrage_grp==2, rankvar(v191) bounded limits(0 1) wagstaff 


tab fic rural_residence [aw=pweight], col 
conindex fic if rural_residence==0, rankvar(v191) bounded limits(0 1) wagstaff 

conindex fic if rural_residence==1, rankvar(v191) bounded limits(0 1) wagstaff 


tab fic place_birth [aw=pweight], col 
conindex fic if place_birth==0, rankvar(v191) bounded limits(0 1) wagstaff 

conindex fic if place_birth==1, rankvar(v191) bounded limits(0 1) wagstaff 


tab fic healthcard [aw=pweight], col 
conindex fic if healthcard==0, rankvar(v191) bounded limits(0 1) wagstaff 

conindex fic if healthcard==1, rankvar(v191) bounded limits(0 1) wagstaff 


gen year=2014

save "C:\Users\kjacob\OneDrive - Kemri Wellcome Trust\Reviews\Caroline Puobebe\MICS and 2014 GDHS\Final 2014 GDHS data.dta", replace 



****************************************************
***Decomposition Analysis

//Make independent predictors as binary variables

recode Sex_of_child 2=0 1=1, gen(sex_of_child)

recode mthrage_grp 0=1 1/2=0, gen(under25)

recode mthrage_grp 1=1 0=0 2=0, gen(age25_29)

recode mthrage_grp 2=1 0/1=0, gen(over29)

recode mothr_maritalstats 0=1 1/2=0, gen(never_married)

recode mothr_maritalstats 1=1 0=0 2=0, gen(currently_married)

recode mothr_maritalstats 2=1 0/1=0, gen(formerly_married)

recode mothr_education 0=1 1/2=0, gen(No_education)

recode mothr_education 1=1 0=0 2=0, gen(primary_education)

recode mothr_education 2=1 0/1=0, gen(secondary_higher)


recode economic_status 0=1 1/2=0, gen(poor)

recode economic_status 1=1 0=0 2=0, gen(middle)

recode economic_status 2=1 0/1=0, gen(rich)


recode birth_order 0=1 1/2=0, gen(one)

recode birth_order 1=1 0=0 2=0, gen(two_three)

recode birth_order 2=1 0/1=0, gen(more_three)


//rename v021 as psu
ren v021 psu

conindex fic [aw=pweight], rank(v191) bounded limits(0 1) wagstaff cluster(psu) /* Overall concentration index*/
sca CI = r(CI) 

global X sex_of_child under25 age25_29 over29 never_married currently_married ///
formerly_married No_education primary_education secondary_higher poor middle ///
rich rural_residence place_birth check_2mths one two_three more_three

qui sum fic [aw=pweight]
sca m_y=r(mean)

qui glm fic $X [aw=pweight], family(binomial) link(logit) cluster(psu)

qui margins , dydx(*) post /*to generate the marginal effects and be able to be picked up*/


foreach x of varlist $X {

sca b_`x'=_b[`x']
sca se_`x' = _se[`x'] 

}
foreach x of varlist $X {

qui{

conindex `x' [aw=pweight], rank(v191) bounded limits(0 1) wagstaff cluster(psu)


sca CI_`x' = r(CI)
sca CI_se = r(CIse)
sum `x' [aw=pweight]

sca elas_`x' = (b_`x' * r(mean))/m_y 

sca con_`x' = elas_`x' * CI_`x'
sca prcnt_`x' = (con_`x'/CI)*100
sca se_cont_`x' = sqrt((se_`x'/b_`x')^2 + (CI_se/CI_`x')^2) * con_`x' /* Delta approximation of the standard error*/
}

di "`x' elasticity:", elas_`x'
di "`x' concentration index:", CI_`x'
di "`x' contribution:", con_`x'
di "`x' percentage contribution:", prcnt_`x'
di "`x' standard errors of contribution:", se_cont_`x'
matrix Caa = nullmat(Caa) \ ///
(elas_`x', CI_`x', con_`x', prcnt_`x', se_cont_`x')
}
matrix rownames Caa= $X
matrix colnames Caa = "Elasticity""CI""Contribution""Contribution%""Err_contribution"
matrix list Caa, format(%8.4f)
clear matrix




save "C:\Users\kjacob\OneDrive - Kemri Wellcome Trust\Reviews\Caroline Puobebe\Ghana 2014\2014.dta", replace


***END OF 2014 GDHS DO FILE***

**************************************************************************
**************************************************************************
**************************************************************************
**2008 DATA SET

// Change working directory
cd "C:\Users\kjacob\OneDrive - Kemri Wellcome Trust\Reviews\Caroline Puobebe\Ghana 2008"


//Load data

use "C:\Users\kjacob\OneDrive - Kemri Wellcome Trust\Reviews\Caroline Puobebe\Ghana 2008\GHBR5ADT\GHBR5AFL.DTA", clear


* rename variables
 ren v006 Month_intvw
 ren v007 Year_intvw
 ren v010 RBirth_Year
 ren v012 RCurrent_Age
 ren v013 RAge_group
 ren v106 Education_level
 ren v130 Religion
 ren v501 marital_status
 ren b4 Sex_of_child
 ren m70 Check_2mths
 ren b1 Cmonth_birth
 ren b2 Cyear_birth
 ren m15 Cplc_delivery
 ren h0 rcvd_OPV0
 ren h2 rcvd_BCG
 ren h3 rcvd_DTP1
 ren h4 rcvd_OPV1
 ren h5 rcvd_DTP2
 ren h6 rcvd_OPV2
 ren h7 rcvd_DTP3
 ren h8 rcvd_OPV3
 ren h9 rcvd_MEASLES
 ren v190 wealth_index
 ren h1 Health_card
 ren v467d Dstnc_hfcilty
 
 *generate age of the child in months (date of interview-date of birth of child) 
 
 gen agemonth= v008-b3
 
  *generate alive children children aged 12-23 months
 gen C_age=0
 replace C_age= 1 if agemonth >=12 & agemonth<=23
 
 *drop children <12 &>23 months
 drop if C_age ==0
 
 * drop dead children (remain with living children aged 12-23 months)
 drop if b5==0
 

*tell Stata the weight (using pweights for robust standard errors), cluster (psu), and strata:
gen pweight=v005/1000000

egen strata = group(v024 v025), label

svyset [pweight=pweight], psu(v021) strata(strata)


*****Generatng vaccinated or not by antigen**
gen bcg_vac=.
replace bcg_vac=0 if (rcvd_BCG==0 | rcvd_BCG==3 | ///
rcvd_BCG==8 |rcvd_BCG==9) 
replace bcg_vac=1 if (rcvd_BCG==1|rcvd_BCG==2)
label define bcg_vac 0 "not vaccinated"  1 "vaccinated",modify
label values bcg_vac bcg_vac
tab bcg_vac




gen dpt1_vac=.
replace dpt1_vac=0 if (rcvd_DTP1==0 | rcvd_DTP1==3 | ///
rcvd_DTP1==8 |rcvd_DTP1==9)
replace dpt1_vac=1 if (rcvd_DTP1==1|rcvd_DTP1==2)
label define dpt1_vac 0 "not vaccinated"  1 "vaccinated",modify
label values dpt1_vac dpt1_vac

tab dpt1_vac

gen dpt2_vac=.
replace dpt2_vac=0 if (rcvd_DTP2==0 | rcvd_DTP2==3 | ///
rcvd_DTP2==8 |rcvd_DTP2==9)
replace dpt2_vac=1 if (rcvd_DTP2==1|rcvd_DTP2==2)
label define dpt2_vac 0 "not vaccinated"  1 "vaccinated",modify
label values dpt2_vac dpt2_vac
tab dpt2_vac

gen dpt3_vac=.
replace dpt3_vac=0 if (rcvd_DTP3==0 | rcvd_DTP3==3 | ///
rcvd_DTP3==8 |rcvd_DTP3==9)
replace dpt3_vac=1 if (rcvd_DTP3==1|rcvd_DTP3==2)
label define dpt3_vac 0 "not vaccinated"  1 "vaccinated",modify
label values dpt3_vac dpt3_vac
tab dpt3_vac

gen opv0_vac=.
replace opv0_vac=0 if ( rcvd_OPV0==0| rcvd_OPV0==3| ///
rcvd_OPV0==8| rcvd_OPV0==9)
replace opv0_vac=1 if (rcvd_OPV0==1| rcvd_OPV0==2)
label define opv0_vac 0 "not vaccinated"  1 "vaccinated",modify
label values opv0_vac opv0_vac
tab opv0_vac

gen opv1_vac=.
replace opv1_vac=0 if (rcvd_OPV1==0| rcvd_OPV1==3| ///
rcvd_OPV1==8| rcvd_OPV1==9)
replace opv1_vac=1 if (rcvd_OPV1==1| rcvd_OPV1==2)
label define opv1_vac 0 "not vaccinated"  1 "vaccinated",modify
label values opv1_vac opv1_vac
tab opv1_vac

gen opv2_vac=.
replace opv2_vac=0 if (rcvd_OPV2==0| rcvd_OPV2==3| ///
rcvd_OPV2==8| rcvd_OPV2==9)
replace opv2_vac=1 if (rcvd_OPV2==1| rcvd_OPV2==2)
label define opv2_vac 0 "not vaccinated"  1 "vaccinated",modify
label values opv2_vac opv2_vac
tab opv2_vac

gen opv3_vac=.
replace opv3_vac=0 if ( rcvd_OPV3==0| rcvd_OPV3==3| ///
rcvd_OPV3==8| rcvd_OPV3==9)
replace opv3_vac=1 if (rcvd_OPV3==1| rcvd_OPV3==2)
label define opv3_vac 0 "not vaccinated"  1 "vaccinated",modify
label values opv3_vac opv3_vac
tab opv3_vac

gen measles_vac=.
replace measles_vac=0 if (rcvd_MEASLES==0| ///
rcvd_MEASLES==3|rcvd_MEASLES==8|rcvd_MEASLES==9)
replace measles_vac=1 if (rcvd_MEASLES==1|rcvd_MEASLES==2)
label define measles_vac 0 "not vaccinated"  1 "vaccinated",modify
label values measles_vac measles_vac
tab measles_vac


******generating immunization status for only BCG, OPV1, OPV2, OPV3, DPT1, DPT2, DPT3 and Measles
gen immunization_status1=.
replace immunization_status1=0 if (bcg_vac==0& dpt1_vac==0& ///
dpt2_vac==0& dpt3_vac==0& opv1_vac==0& opv2_vac==0& opv3_vac==0& measles_vac==0)
replace immunization_status1=1 if (bcg_vac==1|dpt1_vac==1| ///
dpt2_vac==1|dpt3_vac==1|opv1_vac==1|opv2_vac==1|opv3_vac==1|measles_vac==1)
replace immunization_status1=2 if (bcg_vac==1 & dpt1_vac==1& ///
dpt2_vac==1& dpt3_vac==1& opv1_vac==1& opv2_vac==1& opv3_vac==1& measles_vac==1)
label define immunization_status1 0 "not immunized"  1 "partially immunized" 2 "fully immunized", modify
label values immunization_status1 immunization_status1
tab immunization_status1


*****generate non- or under-immunized and fully immunized

gen fic=.
replace fic=0 if (immunization_status1==0 | immunization_status1==1)
replace fic=1 if (immunization_status1==2)
labe define fic 0 "non- or under-immunized" 1 "fully immunized"
label values fic fic
tab fic


*****vaccination coverage for each vaccine

//Table 2 - Distribution of vaccination coverage by vaccine type.
tab bcg_vac
svy: prop bcg_vac 

tab dpt1_vac
svy: prop dpt1_vac 

tab dpt2_vac
svy: prop dpt2_vac 

tab dpt3_vac
svy: prop dpt3_vac 

tab opv1_vac
svy: prop opv1_vac 

tab opv2_vac
svy: prop opv2_vac 

tab opv3_vac
svy: prop opv3_vac 

tab measles_vac
svy: prop measles_vac 

******received all 8 vaccines
tab immunization_status1 [aweight=pweight] //- Not immunized, partially immunized and fic

tab fic
svy: prop fic  //Binary 

*****Independent factors
** 1. Child Sex
tab Sex_of_child [aweight=pweight]

***2. Mother's age group
 gen mthrage_grp=.
 replace mthrage_grp=0 if (RAge_group==1 | RAge_group==2)
 replace mthrage_grp=1 if (RAge_group==3)
 replace mthrage_grp=2 if (RAge_group==4 | RAge_group==5 | RAge_group==6 | RAge_group==7)
 label define mthrage_grp 0 "<=24" 1 "25-29" 2 ">=30"
 label values mthrage_grp mthrage_grp
 
 ***3. Mother's marital status
 gen mothr_maritalstats=.
 replace mothr_maritalstats=0 if (marital_status==0)
 replace mothr_maritalstats=1 if (marital_status==1 | marital_status==2)
 replace mothr_maritalstats=2 if (marital_status==3 | marital_status==4 | marital_status==5)
 label define  mothr_maritalstats 0 "Never married" 1 "Currently married" 2 "Formerly married"
 label values  mothr_maritalstats   mothr_maritalstats
 
 ***4. Mother's education level
gen mothr_education=.
replace mothr_education=0 if (Education_level==0)
replace mothr_education=1 if (Education_level==1)
replace mothr_education=2 if (Education_level==2 | Education_level==3)
label define mothr_education 0 "No education" 1 "Primary" 2 "Secondary/Higher"
label values mothr_education mothr_education



***5. socio-economic status/wealth index
 gen economic_status=.
 replace economic_status=0 if (wealth_index==1 | wealth_index==2)
 replace economic_status=1 if (wealth_index==3)
 replace economic_status=2 if (wealth_index==4| wealth_index==5)
 label define economic_status 0 "Poor" 1 "Middle" 2 "Rich"
 label values economic_status economic_status
 
 ***6. generate Rural residence  
 gen rural_residence=.
 replace rural_residence=0 if (v025==1)
 replace rural_residence=1 if (v025==2)
 label define rural_residence 0 "No/urban" 1 "yes/rural", modify
 label values rural_residence rural_residence
 
 ***7. Child' place of birth/delivery
 gen place_birth=.
 replace place_birth=0 if (Cplc_delivery==11 | Cplc_delivery==12 | Cplc_delivery==96)
 replace place_birth=1 if (Cplc_delivery==21 | Cplc_delivery==22 | Cplc_delivery==23 | Cplc_delivery==26 | Cplc_delivery==31 | Cplc_delivery==33)
 label define place_birth 0 "Home" 1 "Hospital/Health Facilities", modify
 label values place_birth place_birth
 
***8. child checkup within two months 
 gen check_2mths=.
 replace check_2mths=0 if (Check_2mths==0)
 replace check_2mths=1 if (Check_2mths==1)
 label define check_2mths 0 "Not checked " 1 "checked within 2months", modify
 label values check_2mths check_2mths
 ***9. Distance to health facility (big problem/not a big problem)
 gen distc_a_problm=.
 replace distc_a_problm=0 if Dstnc_hfcilty==2
 replace distc_a_problm=1 if Dstnc_hfcilty==1
 label define distc_a_problm 0 "no" 1 "yes"
 label values distc_a_problm distc_a_problm
 
 
 
 ***10. Birth order
gen birth_order=.
replace birth_order=0 if (bord==1)
replace birth_order=1 if (bord==2 | bord==3)
replace birth_order=2 if (bord>=4)
label define birth_order 0 "1" 1 "2/3" 2 ">=4"
label values birth_order birth_order
 
 ***13. generating with and without vaccination card
gen healthcard=.
replace healthcard=0 if (Health_card==0| Health_card==2| Health_card==3)
replace healthcard=1 if (Health_card==1)
label define healthcard 0 "without healthcard" 1 "with health card"
label values healthcard healthcard

tab healthcard [aweight=pweight]



***************************************************************************
***************************************************************************

//Inequality analysis

//Concentartion indices
//1. BCG
conindex bcg_vac, rankvar(v191) bounded limits(0 1) wagstaff

//2. DPT1
conindex dpt1_vac, rankvar(v191) bounded limits(0 1) wagstaff

//3. DPT2
conindex dpt2_vac, rankvar(v191) bounded limits(0 1) wagstaff

//4. DPT3
conindex dpt3_vac, rankvar(v191) bounded limits(0 1) wagstaff


//5. OPV1
conindex opv1_vac, rankvar(v191) bounded limits(0 1) wagstaff

//6. OPV2
conindex opv2_vac, rankvar(v191) bounded limits(0 1) wagstaff

//7. OPV3
conindex opv3_vac, rankvar(v191) bounded limits(0 1) wagstaff

//8. Measles

conindex measles_vac, rankvar(v191) bounded limits(0 1) wagstaff


//9. FIC
conindex fic, rankvar(v191) bounded limits(0 1) wagstaff

///High to low ratio
tab bcg_vac wealth_index [aw=pweight], col

tab dpt1_vac wealth_index [aw=pweight], col  

tab dpt2_vac wealth_index [aw=pweight], col  

tab dpt3_vac wealth_index [aw=pweight], col 


tab opv1_vac wealth_index [aw=pweight], col 

tab opv2_vac wealth_index [aw=pweight], col

tab opv3_vac wealth_index [aw=pweight], col


tab measles_vac wealth_index [aw=pweight], col


tab fic wealth_index [aw=pweight], col


//Overall FIC - Fully immunized child
conindex fic, rankvar(v191) bounded limits(0 1) wagstaff

gen fic_2008=fic

label define fic_2008 0 "Non/unerimmunised" 1 "Fully immunised", modify
label values fic_2008 fic_2008


//Concentration curves
//All 8 vaccine doses NB - All lie on the line of equality
clorenz bcg_vac dpt1_vac dpt2_vac dpt3_vac opv1_vac opv2_vac opv3_vac measles_vac, rank(v191)


clorenz bcg_vac, rank(v191)

clorenz dpt3_vac, rank(v191)

clorenz measles_vac, rank(v191)

clorenz fic, rank(v191)

gen bcg_2008=bcg_vac
gen dpt1_2008=dpt1_vac
gen dpt2_2008=dpt2_vac
gen dpt3_2008=dpt3_vac
gen opv1_2008=opv1_vac
gen opv2_2008=opv2_vac
gen opv3_2008=opv3_vac
gen measles_2008=measles_vac


//Table 3 - Dristibution of fully immunised children by selected socio-demographic factors
tab fic Sex_of_child, col
svy: prop fic, over(Sex_of_child)
 
tab fic mthrage_grp, col 
svy: prop fic, over(mthrage_grp)

 
tab fic mothr_maritalstats, col 
svy: prop fic, over(mothr_maritalstats)
 
tab fic mothr_education, col 
svy: prop fic, over(mothr_education)
 
tab fic economic_status, col 
svy: prop fic, over(economic_status)

 
tab fic rural_residence, col 
svy: prop fic, over(rural_residence)

 
tab fic place_birth, col
svy: prop fic, over(place_birth)
 
 
tab fic check_2mths, col
svy: prop fic, over(check_2mths)
 
 
tab fic birth_order, col
svy: prop fic, over(birth_order)



save "C:\Users\kjacob\OneDrive - Kemri Wellcome Trust\Reviews\Caroline Puobebe\Ghana 2008\2008.dta", replace


****************************************************
***Decomposition Analysis

//Make independent predictors as binary variables

recode Sex_of_child 2=0 1=1, gen(sex_of_child)

recode mthrage_grp 0=1 1/2=0, gen(under25)

recode mthrage_grp 1=1 0=0 2=0, gen(age25_29)

recode mthrage_grp 2=1 0/1=0, gen(over29)

recode mothr_maritalstats 0=1 1/2=0, gen(never_married)

recode mothr_maritalstats 1=1 0=0 2=0, gen(currently_married)

recode mothr_maritalstats 2=1 0/1=0, gen(formerly_married)

recode mothr_education 0=1 1/2=0, gen(No_education)

recode mothr_education 1=1 0=0 2=0, gen(primary_education)

recode mothr_education 2=1 0/1=0, gen(secondary_higher)


recode economic_status 0=1 1/2=0, gen(poor)

recode economic_status 1=1 0=0 2=0, gen(middle)

recode economic_status 2=1 0/1=0, gen(rich)


recode birth_order 0=1 1/2=0, gen(one)

recode birth_order 1=1 0=0 2=0, gen(two_three)

recode birth_order 2=1 0/1=0, gen(more_three)


//rename v021 as psu
ren v021 psu

conindex fic [aw=pweight], rank(v191) bounded limits(0 1) wagstaff cluster(psu) /* Overall concentration index*/
sca CI = r(CI) 

global X sex_of_child under25 age25_29 over29 never_married currently_married ///
formerly_married No_education primary_education secondary_higher poor middle ///
rich rural_residence place_birth check_2mths one two_three more_three

qui sum fic [aw=pweight]
sca m_y=r(mean)

qui glm fic $X [aw=pweight], family(binomial) link(logit) cluster(psu)

qui margins , dydx(*) post /*to generate the marginal effects and be able to be picked up*/


foreach x of varlist $X {

sca b_`x'=_b[`x']
sca se_`x' = _se[`x'] 

}
foreach x of varlist $X {

qui{

conindex `x' [aw=pweight], rank(v191) bounded limits(0 1) wagstaff cluster(psu)


sca CI_`x' = r(CI)
sca CI_se = r(CIse)
sum `x' [aw=pweight]

sca elas_`x' = (b_`x' * r(mean))/m_y 

sca con_`x' = elas_`x' * CI_`x'
sca prcnt_`x' = (con_`x'/CI)*100
sca se_cont_`x' = sqrt((se_`x'/b_`x')^2 + (CI_se/CI_`x')^2) * con_`x' /* Delta approximation of the standard error*/
}

di "`x' elasticity:", elas_`x'
di "`x' concentration index:", CI_`x'
di "`x' contribution:", con_`x'
di "`x' percentage contribution:", prcnt_`x'
di "`x' standard errors of contribution:", se_cont_`x'
matrix Caa = nullmat(Caa) \ ///
(elas_`x', CI_`x', con_`x', prcnt_`x', se_cont_`x')
}
matrix rownames Caa= $X
matrix colnames Caa = "Elasticity""CI""Contribution""Contribution%""Err_contribution"
matrix list Caa, format(%8.4f)
clear matrix


save "C:\Users\kjacob\OneDrive - Kemri Wellcome Trust\Reviews\Caroline Puobebe\Ghana 2008\2008.dta", replace

**************************************************************************
**************************************************************************
** End of 2008 do file


//Append 2014 dataset

append using "C:\Users\kjacob\OneDrive - Kemri Wellcome Trust\Reviews\Caroline Puobebe\Ghana 2014\2014.dta"


clorenz bcg_2008 bcg_2014, rank(v191)

clorenz dpt1_2008 dpt1_2014, rank(v191)

clorenz dpt2_2008 dpt2_2014, rank(v191)


clorenz dpt3_2008 dpt3_2014, rank(v191)

clorenz opv1_2008 opv1_2014, rank(v191)

clorenz opv2_2008 opv2_2014, rank(v191)

clorenz opv3_2008 opv3_2014, rank(v191)

clorenz measles_2008 measles_2014, rank(v191)


clorenz fic_2008 fic_2014, rank(v191)

cd "C:\Users\kjacob\OneDrive - Kemri Wellcome Trust\Reviews\Caroline Puobebe"

graph combine bcg.gph dpt3.gph measles.gph fic.gph







