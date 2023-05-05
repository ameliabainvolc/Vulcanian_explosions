# Vulcanian_explosions
Codes calculating parameters relevant to Vulcanian explosions

Toramaru_2006_v1.m and Toramaru_2006_v2.m calculate the absolute value of the decompression rate during a Vulcanian explosion based on the bubble number density of the interior of breadcrust bomb samples ('inflated' in the terminology of Bain et al., 2019a). All equations sourced from Toramaru (2006), with input data taken from Bain et al. (2019a), such as melt H2O content, melt SiO2 content (contained in input_data.xlsx). The bubble number density for samples named ABx was calculated by MEarthSci student Nathan Reid (University of Edinburgh, 2023) using FOAMS (Shea et al., 2010). Melt density calculated based on geochemical data from Bain et al. (2019a). v1 and v2 differ only in terms of the melt temperature considered (see code for details). Each code calculates two values of the decompression rate, with and without accounting for the effect of CO2 on interfacial tension (see code for details).

Potential issues: DZB2000_Cw_T_P and DBZX2004_T_P_Cs do not seem to have the right order of magnitude so there is a potential error in those calculations. Work is continuing to identify the source of the problem.


References:

Bain, A.A., Calder, E.S., Cortés, J.A., Cortés, G.P. and Loughlin, S.C., 2019a. Textural and geochemical constraints on andesitic plug emplacement prior to the 2004–2010 vulcanian explosions at Galeras volcano, Colombia. Bulletin of Volcanology, 81, pp.1-25.

Bain, A.A., Lamur, A., Kendrick, J.E., Lavallée, Y., Calder, E.S., Cortés, J.A., Butler, I.B. and Cortés, G.P., 2019b. Constraints on the porosity, permeability and porous micro-structure of highly-crystalline andesitic magma during plug formation. Journal of Volcanology and Geothermal Research, 379, pp.72-89.

Bain, A.A., Kendrick, J.E., Lamur, A., Lavallée, Y., Calder, E.S., Cortés, J.A., Cortés, G.P., Gómez Martinez, D. and Torres, R.A., 2021. Micro-textural controls on magma rheology and Vulcanian explosion cyclicity. Frontiers in Earth Science, p.703.

Shea, T., Houghton, B.F., Gurioli, L., Cashman, K.V., Hammer, J.E. and Hobden, B.J., 2010. Textural studies of vesicles in volcanic rocks: an integrated methodology. Journal of Volcanology and Geothermal Research, 190(3-4), pp.271-289.

Toramaru, A., 2006. BND (bubble number density) decompression rate meter for explosive volcanic eruptions. Journal of Volcanology and Geothermal Research, 154(3-4), pp.303-316.
