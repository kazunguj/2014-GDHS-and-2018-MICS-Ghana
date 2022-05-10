

**Import Child Health dataset 
clear
import spss using "C:\Users\kjacob\OneDrive - Kemri Wellcome Trust\Reviews\Caroline Puobebe\MICS dataset\Ghana MICS6 SPSS Datasets\ch.sav"

**Restrict data to only children age 12 to 23 months
gen C_age=0
replace C_age= 1 if CAGE >=12 & CAGE<=23
replace C_age=. if CAGE==.
tab C_age, m
drop if C_age==0



sort HH1 HH2 UF4 //cluster,household and mother/caretakers line numbers
save "C:\Users\kjacob\OneDrive - Kemri Wellcome Trust\Reviews\Caroline Puobebe\MICS dataset\Ghana MICS6 SPSS Datasets\CH.dta", replace



* rename variables | generate new variables
 ren UF7D day_intvw
 ren UF7M Month_intvw
 ren UF7Y Year_intvw
 
 


 ren HL4 Sex_of_child
 
 ren UB1M Cmonth_birth
 ren UB1Y Cyear_birth

 
 **BCG
 ren IM6BY year_BCG
 ren IM14 mrecall_BCG
 gen bcg_vac =0
 replace bcg_vac=1 if (year_BCG!=. | mrecall_BCG==1)
 tab bcg_vac [aw=chweight]
 
 ren IM16 mrecall_OPV
 label var mrecall_OPV "Child ever given polio drops"
 
 ren IM18 times_polio
 label var times_polio "Times received polio drops"
 recode times_polio 8=.
 
 **OPV
 ren IM6P0Y year_OPV0
 ren IM6P1Y year_OPV1
 ren IM6P2Y year_OPV2
 ren IM6P3Y year_OPV3
 
 gen opv0_vac = 0
 replace opv0_vac = 1 if (mrecall_OPV==1 | year_OPV0!=.)
  tab opv0_vac [aw=chweight]
 
 gen opv1_vac = 0
 replace opv1_vac = 1 if (mrecall_OPV==1 & times_polio>=2) | (year_OPV1!=. & times_polio>=2) | (mrecall_OPV==1 & times_polio>=2 & year_OPV1!=.)
 tab opv1_vac [aw=chweight]
 
 gen opv2_vac = 0
 replace opv2_vac = 1 if (mrecall_OPV==1 & times_polio>=3) | (year_OPV2!=. & times_polio>=3) | (mrecall_OPV==1 & times_polio>=3 & year_OPV2!=.)
 tab opv2_vac [aw=chweight]
  
 gen opv3_vac = 0
 replace opv3_vac = 1 if (mrecall_OPV==1 & times_polio>=4) | (year_OPV3!=. & times_polio>=4) | (mrecall_OPV==1 & year_OPV3!=. & times_polio>=4)
 tab opv3_vac [aw=chweight]
 
 
 
 **Penta
 ren IM20 mrecall_penta
 ren IM21 times_penta
 ren IM6PENTA1Y year_penta1 // penta contains DPT-HIB-HEPB doses
 ren IM6PENTA2Y year_penta2
 ren IM6PENTA3Y year_penta3
 
 gen penta1_vac = 0
 replace penta1_vac = 1 if (mrecall_penta==1 | year_penta1!=. & times_penta>=1)
 tab penta1_vac [aw=chweight]
  
  gen penta2_vac = 0
 replace penta2_vac = 1 if (mrecall_penta==1 | year_penta2!=. & times_penta>=2) 
 tab penta2_vac [aw=chweight]
 
  gen penta3_vac = 0
 replace penta3_vac = 1 if (mrecall_penta==1 | year_penta3!=. & times_penta>=3)
 tab penta3_vac [aw=chweight]
 
 
 **PCV
 ren IM22 mrecall_PCV
 ren IM23 times_PCV 
 ren IM6PCV1Y year_PCV1
 ren IM6PCV2Y year_PCV2
 ren IM6PCV3Y year_PCV3
 
 gen pcv1_vac = 0
 replace pcv1_vac = 1 if (mrecall_PCV==1 | year_PCV1!=. & times_PCV>=1)
 tab pcv1_vac [aw=chweight]
 
 gen pcv2_vac = 0
 replace pcv2_vac = 1 if (mrecall_PCV==1 | year_PCV2!=. & times_PCV>=2) 
 tab pcv2_vac [aw=chweight]
 

  gen pcv3_vac = 0
 replace pcv3_vac = 1 if (mrecall_PCV==1 | year_PCV3!=. & times_PCV>=3) 
 tab pcv3_vac [aw=chweight] 
 
 **Rota
 ren IM24 mrecall_Rota
 ren IM25 times_Rota 
 ren IM6R1Y year_Rota1
 ren IM6R2Y year_Rota2
 
 gen rota1_vac = 0
 replace rota1_vac = 1 if (mrecall_Rota==1 | year_Rota1!=.)
 tab rota1_vac [aw=chweight]
 
 gen rota2_vac = 0
 replace rota2_vac = 1 if (mrecall_Rota==1 | year_Rota2!=. & times_Rota>=2) 
 tab rota2_vac [aw=chweight]
 
 
 **Yellow Fever
 ren IM6YD day_YellowF
 ren IM6YM month_YellowF
 ren IM6YY year_YellowF
 ren IM27 mrecall_YellowF 
 
 gen yellow_vac = 0
 replace yellow_vac = 1 if (mrecall_YellowF==1 | year_YellowF!=.)
 tab yellow_vac [aw=chweight]
 
 
 **Measles
 ren IM6MY year_MEASLES
 ren IM6MD day_MEASLES
 ren IM6MM month_MEASLES
 ren IM26A mrecall_MEASLES
 gen measles_vac = 0
 replace measles_vac = 1 if (mrecall_MEASLES==1 | year_MEASLES!=.)
 tab measles_vac [aw=chweight]



 ren windex5 wealth_index
 ren IM2 health_card //vaccination card of the child seen
 *ren v467d Dstnc_hfcilty //not found
 ren HH6 residence_type



******generating immunization status for only BCG, OPV0, OPV1, OPV2, OPV3, Penta1, Penta2, Penta3, PCV1, PCV2, PCV3, Rota1, Rota 2, and Measles
gen immunization_status1=.
replace immunization_status1=0 if (bcg_vac==0 & penta1_vac==0 & penta2_vac==0 & penta3_vac==0 & pcv1_vac==0 & pcv2_vac==0 & pcv3_vac==0 & rota1_vac==0 & rota2_vac==0 & yellow_vac==0 & measles_vac==0)
replace immunization_status1=1 if (bcg_vac==1 | penta1_vac==1 | penta2_vac==1 | penta3_vac==1 | pcv1_vac==1 | pcv2_vac==1 | pcv3_vac==1 | rota1_vac==1 | rota2_vac==1 | yellow_vac==1 | measles_vac==1)
replace immunization_status1=2 if (bcg_vac==1 & penta1_vac==1 & penta2_vac==1 & penta3_vac==1 & pcv1_vac==1 & pcv2_vac==1 & pcv3_vac==1 & rota1_vac==1 & rota2_vac==1 & yellow_vac==1 & measles_vac==1)
label define immunization_status1 0 "not immunized"  1 "partially immunized" 2 "fully immunized", modify
label values immunization_status1 immunization_status1
tab immunization_status1 [aw=chweight]


*****generate non- or under-immunized and fully immunized

gen fic=.
replace fic=0 if (immunization_status1==0 | immunization_status1==1)
replace fic=1 if (immunization_status1==2)
labe define fic 0 "non- or under-immunized" 1 "fully immunized", modify
label values fic fic
tab fic [aw=chweight]

svyset [pweight=chweight], psu(PSU) strata(stratum)




*****vaccination coverage for each vaccine

//Table 1 - Distribution of vaccination coverage by vaccine type.
tab bcg_vac
svy: prop bcg_vac 

tab opv0_vac
svy: prop opv0_vac 

tab opv1_vac
svy: prop opv1_vac 

tab opv2_vac
svy: prop opv2_vac 

tab opv3_vac
svy: prop opv3_vac 

tab pcv1_vac
svy: prop pcv1_vac

tab pcv2_vac
svy: prop pcv2_vac

tab pcv3_vac
svy: prop pcv3_vac


tab penta1_vac
svy: prop penta1_vac

tab penta2_vac
svy: prop penta2_vac 

tab penta3_vac
svy: prop penta3_vac

tab rota1_vac
svy: prop rota1_vac

tab rota2_vac
svy: prop rota2_vac

tab yellow_vac
svy: prop yellow_vac

tab measles_vac
svy: prop measles_vac 

tab fic
svy: prop fic

save "C:\Users\kjacob\OneDrive - Kemri Wellcome Trust\Reviews\Caroline Puobebe\MICS dataset\Ghana MICS6 SPSS Datasets\childhealth.dta", replace



**Import women dataset 
clear
import spss using "C:\Users\kjacob\OneDrive - Kemri Wellcome Trust\Reviews\Caroline Puobebe\MICS dataset\Ghana MICS6 SPSS Datasets\wm.sav"


**Mothers level of education
recode WB6A (0=0 "None") (1/3=1 "Primary/Middle") (4/6=3 "Secondary/Higher") (9=0 "None"), gen(mom_education)

**Mothers current marital status 
recode MSTATUS (1=1 "Currently married") (2/3=0 "Not Currently married"), gen(mom_marital)


**Mother's exposure to media 
gen mom_media=.
replace mom_media = 0 if (MT1==0 & MT2==0 & MT3==0)
replace mom_media = 1 if (MT1>0 | MT2>0 | MT3>0)
replace mom_media = . if (MT1==. & MT2==. & MT3==.)
label define mom_media 0 "Not exposed" 1 "Exposed", replace 
label values mom_media mom_media
tab mom_media

ren WM3 UF4 //woman's line number=mothers line number
sort HH1 HH2 UF4

merge 1:m HH1 HH2 UF4 using "C:\Users\kjacob\OneDrive - Kemri Wellcome Trust\Reviews\Caroline Puobebe\MICS dataset\Ghana MICS6 SPSS Datasets\childhealth.dta", update

drop if  CM17==0 //Drop those that do not have at least one live birth in the last two years
keep if CAGE_6 ==3

keep  if CAGE>11 & CAGE<24 
sort HH1 HH2
drop _merge

save "C:\Users\kjacob\OneDrive - Kemri Wellcome Trust\Reviews\Caroline Puobebe\MICS dataset\Ghana MICS6 SPSS Datasets\Childwithwomenindicators.dta", replace


***Import Household dataset 
clear
import spss using "C:\Users\kjacob\OneDrive - Kemri Wellcome Trust\Reviews\Caroline Puobebe\MICS dataset\Ghana MICS6 SPSS Datasets\hh.sav"

recode windex5 (0=.) (1=0 "Poorest") (2=1 "Poor") (3=2 "Middle") (4=3 "Rich") (5=4 "Richest"), gen(hh_wealth_status)

sort HH1 HH2
merge m:m HH1 HH2 using "C:\Users\kjacob\OneDrive - Kemri Wellcome Trust\Reviews\Caroline Puobebe\MICS dataset\Ghana MICS6 SPSS Datasets\Childwithwomenindicators.dta", update

keep if CAGE_6 ==3


save "C:\Users\kjacob\OneDrive - Kemri Wellcome Trust\Reviews\Caroline Puobebe\MICS dataset\Ghana MICS6 SPSS Datasets\MICS_data2018_immunization.dta", replace


 ren WB4 RCurrent_Age
 recode RCurrent_Age (15/19 = 0 "15-19") (20/24 = 1 "20-24") (25/29 = 2 "25-29") (30/34 = 3 "30-34") (35/39 = 4 "35-39") (40/44 = 5 "40-44") (45/max = 6 "45+"), gen(RAge_group) 
 *gen RAge_group = 5 * ceil(RCurrent_Age/5)
 tab RAge_group
 
 
ren PN11 Check_2mths //wm file 
ren WB6A Education_level //wm file
 ren HC1A Religion //hh file (household head religion)
 ren MA6 marital_status //wm file 
 ren MN20 Cplc_delivery //wm file 
 ren WB3Y RBirth_Year //wm file
 ren CM1 mother //wm file


***TABLE 2 - DISTRIBUTION OF VACCINATION BY SELECTED VARIABLES
*****Independent factors
** 1. Child Sex
tab Sex_of_child
tab Sex_of_child [aweight=chweight]
tab Sex_of_child if fic==1
svy: prop fic if Sex_of_child==1

svy: prop fic if Sex_of_child==2

***2. Mother's age group
 gen mthrage_grp=.
 replace mthrage_grp=0 if (RAge_group==0 | RAge_group==1)
 replace mthrage_grp=1 if (RAge_group==2)
 replace mthrage_grp=2 if (RAge_group==3 | RAge_group==4 | RAge_group==5 | RAge_group==6)
 label define mthrage_grp 0 "<=24" 1 "25-29" 2 ">=30"
 label values mthrage_grp mthrage_grp
 tab mthrage_grp
 tab mthrage_grp if fic ==1
 svy: prop fic if mthrage_grp==0
 svy: prop fic if mthrage_grp==1
 svy: prop fic if mthrage_grp==2
 
 `Variable has so many missing values'
 /*
 
 ***3. Mother's marital status
 gen mothr_maritalstats=.
 replace mothr_maritalstats=0 if (marital_status==1)
 replace mothr_maritalstats=1 if (marital_status==2 | marital_status==3)
 replace mothr_maritalstats=2 if (marital_status==3 | marital_status==4 | marital_status==5)
 label define  mothr_maritalstats 0 "Never married" 1 "Currently married" 2 "Formerly married"
 label values  mothr_maritalstats   mothr_maritalstats
 
 recode mothr_maritalstats (0=0 "Not currently married") (1=1 "Currently married") (2=0 "Not Currently married"), gen(current_marital)
 

 
 ***4. Mother's education level
gen mothr_education=.
replace mothr_education=0 if (Education_level==0)
replace mothr_education=1 if (Education_level==1)
replace mothr_education=2 if (Education_level==2 | Education_level==3)
label define mothr_education 0 "No education" 1 "Primary" 2 "Secondary/Higher"
label values mothr_education mothr_education
 */

***5. socio-economic status/wealth index
 gen economic_status=.
 replace economic_status=0 if (wealth_index==1 | wealth_index==2)
 replace economic_status=1 if (wealth_index==3)
 replace economic_status=2 if (wealth_index==4| wealth_index==5)
 label define economic_status 0 "Poor" 1 "Middle" 2 "Rich"
 label values economic_status economic_status
 
 tab economic_status
 tab economic_status if fic ==1
 *svy: prop fic if economic_status==0
 *svy: prop fic if economic_status==1
 mean fic [aw=chweight ], over(economic_status)
 
 ***6. generate residence  
tab residence_type
tab residence_type if fic==1
mean fic [aw=chweight], over(residence_type)
 
 ***7. Child' place of birth/delivery
 gen place_birth=.
 replace place_birth=0 if (Cplc_delivery==11 | Cplc_delivery==12 | Cplc_delivery==96)
 replace place_birth=1 if (Cplc_delivery==21 | Cplc_delivery==22 | Cplc_delivery==23 | Cplc_delivery==26 | Cplc_delivery==31 | Cplc_delivery==32 | Cplc_delivery==33 | Cplc_delivery==36)
 label define place_birth 0 "Home" 1 "Hospital/Health Facilities", modify
 label values place_birth place_birth
 
 tab place_birth
 tab place_birth if fic ==1
 mean fic [aw=chweight], over(place_birth)
 
***8. child checkup within two months  - Has very few observations
/*
 gen check_2mths=.
 replace check_2mths=0 if (Check_2mths==2)
 replace check_2mths=1 if (Check_2mths==1)
 label define check_2mths 0 "Not checked " 1 "checked within 2months", modify
 label values check_2mths check_2mths
 
 tab check_2mths
 tab check_2mths if fic==1
 mean fic [aw=chweight], over(check_2mths)
 
 
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
  */
  
  
 ***13. generating with and without vaccination card
gen healthcard=.
replace healthcard=0 if (health_card==4)
replace healthcard=1 if (health_card==1 |  health_card==2| health_card==3)
label define healthcard 0 "without healthcard" 1 "with health card"
label values healthcard healthcard

tab healthcard
tab healthcard if fic==1
mean fic [aweight=chweight], over(healthcard)


***************************************************************************

//Inequality analysis
net install siilogit, from("http://www.equidade.org/files") //Run this to obtain the siilogit ado files

//Concentartion indices
//1. BCG
tab bcg_vac wealth_index [aw=chweight], col 
siilogit wealth_index bcg_vac, nograph


conindex bcg_vac, rankvar(wscore) bounded limits(0 1) wagstaff

tab bcg_vac residence_type [aw=chweight], col

tab bcg_vac Sex_of_child [aw=chweight], col

//2. OPV0
tab opv0_vac wealth_index [aw=chweight], col 
siilogit wealth_index opv0_vac, nograph


conindex opv0_vac, rankvar(wscore) bounded limits(0 1) wagstaff

tab opv0_vac residence_type [aw=chweight], col

tab opv0_vac Sex_of_child [aw=chweight], col

//4. OPV2
tab opv2_vac wealth_index [aw=chweight], col 
siilogit wealth_index opv2_vac, nograph


conindex opv2_vac, rankvar(wscore) bounded limits(0 1) wagstaff

tab opv2_vac residence_type [aw=chweight], col

tab opv2_vac Sex_of_child [aw=chweight], col




//5. OPV3
tab opv3_vac wealth_index [aw=chweight], col 
siilogit wealth_index opv3_vac, nograph


conindex opv3_vac, rankvar(wscore) bounded limits(0 1) wagstaff

tab opv3_vac residence_type [aw=chweight], col

tab opv3_vac Sex_of_child [aw=chweight], col


//6. PCV1
tab pcv1_vac wealth_index [aw=chweight], col 
siilogit wealth_index pcv1_vac, nograph


conindex pcv1_vac, rankvar(wscore) bounded limits(0 1) wagstaff

tab pcv1_vac residence_type [aw=chweight], col

tab pcv1_vac Sex_of_child [aw=chweight], col

//7. PCV2
tab pcv2_vac wealth_index [aw=chweight], col 
siilogit wealth_index pcv2_vac, nograph


conindex pcv2_vac, rankvar(wscore) bounded limits(0 1) wagstaff

tab pcv2_vac residence_type [aw=chweight], col

tab pcv2_vac Sex_of_child [aw=chweight], col



//8. PCV3
tab pcv3_vac wealth_index [aw=chweight], col 
siilogit wealth_index pcv3_vac, nograph


conindex pcv3_vac, rankvar(wscore) bounded limits(0 1) wagstaff

tab pcv3_vac residence_type [aw=chweight], col

tab pcv3_vac Sex_of_child [aw=chweight], col


//9.PENTA1
tab penta1_vac wealth_index [aw=chweight], col 
siilogit wealth_index penta1_vac, nograph


conindex penta1_vac, rankvar(wscore) bounded limits(0 1) wagstaff

tab penta1_vac residence_type [aw=chweight], col

tab penta1_vac Sex_of_child [aw=chweight], col

//10. PENTA2
tab penta2_vac wealth_index [aw=chweight], col 
siilogit wealth_index penta2_vac, nograph


conindex penta2_vac, rankvar(wscore) bounded limits(0 1) wagstaff

tab penta2_vac residence_type [aw=chweight], col

tab penta2_vac Sex_of_child [aw=chweight], col

//11. PENTA3
tab penta3_vac wealth_index [aw=chweight], col 
siilogit wealth_index penta3_vac, nograph


conindex penta3_vac, rankvar(wscore) bounded limits(0 1) wagstaff

tab penta3_vac residence_type [aw=chweight], col

tab penta3_vac Sex_of_child [aw=chweight], col

//12. ROTA1
tab rota1_vac wealth_index [aw=chweight], col 
siilogit wealth_index rota1_vac, nograph


conindex rota1_vac, rankvar(wscore) bounded limits(0 1) wagstaff

tab rota1_vac residence_type [aw=chweight], col

tab rota1_vac Sex_of_child [aw=chweight], col

//13. ROTA2
tab rota2_vac wealth_index [aw=chweight], col 
siilogit wealth_index rota2_vac, nograph


conindex rota2_vac, rankvar(wscore) bounded limits(0 1) wagstaff

tab rota2_vac residence_type [aw=chweight], col

tab rota2_vac Sex_of_child [aw=chweight], col



//14. Yellow Fever
tab yellow_vac wealth_index [aw=chweight], col 
siilogit wealth_index yellow_vac, nograph


conindex yellow_vac, rankvar(wscore) bounded limits(0 1) wagstaff

tab yellow_vac residence_type [aw=chweight], col

tab yellow_vac Sex_of_child [aw=chweight], col

//15. Measles
tab measles_vac wealth_index [aw=chweight], col 
siilogit wealth_index measles_vac, nograph


conindex measles_vac, rankvar(wscore) bounded limits(0 1) wagstaff

tab measles_vac residence_type [aw=chweight], col

tab measles_vac Sex_of_child [aw=chweight], col

//16. FIC
tab fic wealth_index [aw=chweight], col 
siilogit wealth_index fic, nograph


conindex fic, rankvar(wscore) bounded limits(0 1) wagstaff

tab fic residence_type [aw=chweight], col

tab fic Sex_of_child [aw=chweight], col




***Generate vaccine specific and year variables
gen bcg_2018 = bcg_vac
gen opv3_2018 = opv3_vac
gen measles_2018 = measles_vac
gen fic_2018 = fic




save "C:\Users\kjacob\OneDrive - Kemri Wellcome Trust\Reviews\Caroline Puobebe\MICS dataset\Ghana MICS6 SPSS Datasets\Final MICS Ghana 2018 Immunization.dta", replace


**Subgroup inequality analysis
recode Sex_of_child (2=0 "Female") (1=1 "Male"), gen(sex_of_child) 

tab fic sex_of_child [aw=chweight], col 
conindex fic if sex_of_child==0, rankvar(wscore) bounded limits(0 1) wagstaff 

conindex fic if sex_of_child==1, rankvar(wscore) bounded limits(0 1) wagstaff 


tab fic mom_education [aw=chweight], col 
conindex fic if mom_education==0, rankvar(wscore) bounded limits(0 1) wagstaff 

conindex fic if mom_education==1, rankvar(wscore) bounded limits(0 1) wagstaff 

conindex fic if mom_education==3, rankvar(wscore) bounded limits(0 1) wagstaff 



tab fic mthrage_grp [aw=chweight], col 
conindex fic if mthrage_grp==0, rankvar(wscore) bounded limits(0 1) wagstaff 

conindex fic if mthrage_grp==1, rankvar(wscore) bounded limits(0 1) wagstaff 

conindex fic if mthrage_grp==2, rankvar(wscore) bounded limits(0 1) wagstaff 




tab fic economic_status [aw=chweight], col 
conindex fic if economic_status==0, rankvar(wscore) bounded limits(0 1) wagstaff 

conindex fic if economic_status==1, rankvar(wscore) bounded limits(0 1) wagstaff 

conindex fic if economic_status==2, rankvar(wscore) bounded limits(0 1) wagstaff 



tab fic residence_type [aw=chweight], col 
conindex fic if residence_type==1, rankvar(wscore) bounded limits(0 1) wagstaff 

conindex fic if residence_type==2, rankvar(wscore) bounded limits(0 1) wagstaff 


tab fic place_birth [aw=chweight], col 
conindex fic if place_birth==0, rankvar(wscore) bounded limits(0 1) wagstaff 

conindex fic if place_birth==1, rankvar(wscore) bounded limits(0 1) wagstaff 


tab fic healthcard [aw=chweight], col 
conindex fic if healthcard==0, rankvar(wscore) bounded limits(0 1) wagstaff 

conindex fic if healthcard==1, rankvar(wscore) bounded limits(0 1) wagstaff 



  

******EQUIPLOTS***
import excel "C:\Users\kjacob\OneDrive - Kemri Wellcome Trust\Reviews\Caroline Puobebe\MICS dataset\Final analysis\Equiplot data.xlsx", sheet("Equiplot data - MICS") firstrow clear

save "C:\Users\kjacob\OneDrive - Kemri Wellcome Trust\Reviews\Caroline Puobebe\MICS dataset\Final analysis\Equiplot data.dta", replace

//Socioeconomic status
equiplot Q1 Q2 Q3 Q4 Q5, over(vaccine) xtitle(Vaccination coverage) ysize(16) xsize(16) xlabel (55 (5) 100)



//Residence

equiplot urban rural, over(vaccine) xtitle(Vaccination coverage) ysize(16) xsize(16) xlabel (60 (10) 100)


//Sex of child

equiplot female male, over(vaccine) xtitle(Vaccination coverage) ysize(16) xsize(16) xlabel (60 (10) 100)


*Place of delivery 
equiplot home hospital, over(vaccine) xtitle(Vaccination coverage) ysize(16) xsize(16) xlabel (60 (10) 100)



cd "C:\Users\kjacob\OneDrive - Kemri Wellcome Trust\Reviews\Caroline Puobebe\MICS dataset\Final analysis"



graph combine ses.gph residence.gph gender.gph


**************************************************************
****************************************************
***CONCENTRATION CURVES*****


use "C:\Users\kjacob\OneDrive - Kemri Wellcome Trust\Reviews\Caroline Puobebe\MICS dataset\Ghana MICS6 SPSS Datasets\Final MICS Ghana 2018 Immunization.dta", clear

clorenz (opv0_vac pcv2_vac penta2_vac pcv1_vac pcv3_vac opv1_vac rota2_vac fic), hweight (chweight) rank(wscore) 


clorenz (rota1_vac measles_vac bcg_vac opv3_vac yellow_vac opv2_vac), hweight (chweight) rank(wscore) 

cd "C:\Users\kjacob\OneDrive - Kemri Wellcome Trust\Reviews\Caroline Puobebe\MICS dataset\Final analysis"

graph combine CC1.gph CC2.gph


//// DETERMINANTS OF FULLY IMMUNISED CHILD IN THE 2017-18 Ghana MICS data

// Bivariate Analysis
** 1. Sex of the child
svy: logistic fic i.Sex_of_child, base

** 2. Mother's age group
svy: logistic fic i.mthrage_grp, base


** 3. Mother's marital status

svy: logistic fic i.mom_marital, base


** 4. Mother's education
svy: logistic fic i.mom_education, base


** 5. Socio-economic status
svy: logistic fic i.hh_wealth_status, base


** 6. Residence Type
svy: logistic fic i.residence_type, base

** 7. Place of child birth - home or health facility
svy: logistic fic i.place_birth, base

/*
** 8. Whether mother got a check up within the last 12 months
svy: logistic fic i.check_2mths, base


** 9. Whether distance to health facility is a problem
svy: logistic fic i.distc_a_problm, base

** 10. Birth order
svy: logistic fic i.birth_order, base
*/
** 11. Exposure to media
svy: logistic fic i.mom_media, base


**12. Has health card 
svy: logistic fic i.healthcard, base


**Check for Multicollinearity
correlate Sex_of_child mthrage_grp economic_status residence_type place_birth check_2mths healthcard



svy: logistic fic i.Sex_of_child i.mthrage_grp i.mom_marital i.mom_education i.hh_wealth_status i.residence_type i.place_birth i.mom_media i.healthcard, base


save "C:\Users\kjacob\OneDrive - Kemri Wellcome Trust\Reviews\Caroline Puobebe\MICS and 2014 GDHS\Final 2018 Ghana MICS data.dta", replace



************************************
**************************************
**APPEND THE 2014 DATASET TO PRODUCE CONCENTRATION CURVES FOR SELECTED VACCINES
use "C:\Users\kjacob\OneDrive - Kemri Wellcome Trust\Reviews\Caroline Puobebe\MICS and 2014 GDHS\Final 2018 Ghana MICS data.dta", clear

gen year=2018 

append using "C:\Users\kjacob\OneDrive - Kemri Wellcome Trust\Reviews\Caroline Puobebe\MICS and 2014 GDHS\Final 2014 GDHS data.dta"

gen rank=.
replace rank = wscore if year==2018
replace rank = v191 if year==2014

save "C:\Users\kjacob\OneDrive - Kemri Wellcome Trust\Reviews\Caroline Puobebe\MICS and 2014 GDHS\2014 GDHS and 2018 MICS combined data.dta", replace 


****Concentration curves
*1. BCG 
clorenz bcg_2014 bcg_2018, rank(rank)

*2. DPT3
clorenz dpt3_2014 penta3_vac, rank(rank)


*3. Measles
clorenz measles_2014 measles_2018, rank(rank)

*4. Fully immunised child 
clorenz fic_2014 fic_2018, rank(rank)
