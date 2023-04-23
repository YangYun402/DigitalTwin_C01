function L=getL(in)
mu=[45.6929054237312;45.6722058592253;26.9561601079987;26.9573619581712;57.9685123146211;27.6495760145445;29.0495670097896;27.2102825697128;27.2026906287018;29.2665753501780;27.8475108765087;29.2673342261253;42.6651637047331;50.9316316531223;73.8564710786507;51.4205813883183;29.0641664496986;39.7676797948646;38.0097043061020;35.6927609893480;44.6642273764283;45.6997152310060;59.4338433672517;48.6871747556124;43.6572178485388;22.7889316414029;24.9242149687065;25.5116497068226;7073.95555555555];
sig=[11.6746194920400;16.3750605906493;2.58786542304629;2.58837857026016;19.5912308668546;2.63367419715062;3.88123392598869;2.24189909617995;2.23590080498844;3.09690468189161;2.02242069003030;3.09576470222654;12.4551958020044;13.7926782454400;31.3940154151030;13.6297764558040;3.89441672281978;8.95853820000714;8.09898982607871;6.49961241167567;11.5244769218244;11.8044934022821;21.1301682897077;12.0802745586864;8.38749684092973;1.22463234587027;0.410745840920833;0.614917040000688;6137.36385012204];
in=(in' - mu) ./ sig;
global net;
[net,L] = predictAndUpdateState(net,in);
end