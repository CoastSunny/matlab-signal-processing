%==========================================================================
%% This script is part of the BCI toolbox, it's used by the main function to compute the "mean value for each channels"
%==========================================================================
% This script compute the 
%% Correlation
o_synchro_time_corr_ch=[];
temp0=[];
if (Nepochs==1)
o_synchro_time_corr_epo=[];
if Nsubj==1 
o_synchro_time_corr=[];
end
end

% Apply a filter here according to the choice of the user
apply_filter=init_parameter.apply_filter(Nmethode);
%% Only for the synchronisation m�thodes
cpt=1; % compteur de combinaison
indice_combinaison=1:size(s_EEG.data,1)*(size(s_EEG.data,1)-1)/2;
channels_combinaison=combnk(1:size(s_EEG.data,1),2);
for Nchannel1=1:size(s_EEG.data,1)   
i_EEG_1=s_EEG.data(Nchannel1,:,Nepochs);
for Nchannel2 = Nchannel1+1:nb_channel   

i_EEG_2=s_EEG.data(Nchannel2,:,Nepochs);

if (apply_filter==1)
for Nband=1:init_parameter.nb_bands
filt=init_parameter.filt_band_param;
fdata_1 = filter(filt(Nband),i_EEG_1);
fdata_2 = filter(filt(Nband),i_EEG_2);                          

Vai=(fdata_1)';
Vfi=(fdata_2)';
Vam=mean(Vai)*ones(length(Vfi),1);
Vfm=mean(Vfi)*ones(length(Vfi),1);
cor=(sum((Vfi-Vfm).*(Vai-Vam)))/((sqrt(sum((Vfi-Vfm).^2))).*(sqrt(sum((Vai-Vam).^2))));                             


o_synchro_time_corr0=cor;
o_synchro_time_corr_ch=[o_synchro_time_corr_ch; o_synchro_time_corr0];

% Track the identification of the band
if((Nsubj==1)&&(Nepochs==1))
temp0=[temp0; init_parameter.method(Nmethode) indice_combinaison(cpt) init_parameter.selected_band(Nband) ];
end
end
else

Vai=(i_EEG_1)';
Vfi=(i_EEG_2)';
Vam=mean(Vai)*ones(length(Vfi),1);
Vfm=mean(Vfi)*ones(length(Vfi),1);
cor=(sum((Vfi-Vfm).*(Vai-Vam)))/((sqrt(sum((Vfi-Vfm).^2))).*(sqrt(sum((Vai-Vam).^2))));   


o_synchro_time_corr0=cor;
o_synchro_time_corr_ch=[o_synchro_time_corr_ch; o_synchro_time_corr0];
% Track the identification of the band
if ((Nsubj==1)&&(Nepochs==1))
temp0=[temp0;init_parameter.method(Nmethode) indice_combinaison(cpt) nan];
%cpt=cpt+1;
end    
end
cpt=cpt+1;
end
end
o_synchro_time_corr_epo=o_synchro_time_corr_ch;  
o_synchro_time_corr=[o_synchro_time_corr o_synchro_time_corr_epo];
features_results.o_synchro_time_corr=o_synchro_time_corr;
features_results.channels_combinaison=channels_combinaison;
if ((Nsubj==1)&&(Nepochs==1))
features_results.o_synchro_time_corr_band=temp0;
end    


%% Here 


%%
% % %----------------------------------------------------------------------
% % %                  Brain Computer Interface team
% % % 
% % %                            _---~~(~~-_.
% % %                          _{        )   )
% % %                        ,   ) -~~- ( ,-' )_
% % %                       (  `-,_..`., )-- '_,)
% % %                      ( ` _)  (  -~( -_ `,  }
% % %                      (_-  _  ~_-~~~~`,  ,' )
% % %                        `~ -^(    __;-,((()))
% % %                              ~~~~ {_ -_(())
% % %                                     `\  }
% % %                                       { }
% % %   File created by Takfarinas MEDANI
% % %   Creation Date : 21/10/2016
% % %   Updates and contributors :
% % %
% % %   Citation: [creator and contributor names], comprehensive BCI
% % %             toolbox, available online 2016.
% % %           
% % %   Contact info : francois.vialatte@espci.fr          
% % %   Copyright of the contributors, 2016
% % %   Creative Commons License, CC-BY-NC-SA
% % %----------------------------------------------------------------------
