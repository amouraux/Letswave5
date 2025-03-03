function varargout = GLW_butterband(varargin)
% GLW_butterband MATLAB code for GLW_butterband.fig
%
% Author : 
% Andr� Mouraux
% Institute of Neurosciences (IONS)
% Universit� catholique de louvain (UCL)
% Belgium
% 
% Contact : andre.mouraux@uclouvain.be
% This function is part of Letswave 5
% See http://nocions.webnode.com/letswave for additional information
%

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GLW_butterband_OpeningFcn, ...
                   'gui_OutputFcn',  @GLW_butterband_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT




% --- Executes just before GLW_butterband is made visible.
function GLW_butterband_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GLW_butterband (see VARARGIN)
% Choose default command line output for GLW_butterband
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);
% Fill listbox with inputfiles
set(handles.filebox,'String',varargin{2});




% --- Outputs from this function are returned to the command line.
function varargout = GLW_butterband_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Get default command line output from handles structure




% --- Executes during object creation, after setting all properties.
function figure_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called




% --- Executes on selection change in filebox.
function filebox_Callback(hObject, eventdata, handles)
% hObject    handle to filebox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes during object creation, after setting all properties.
function filebox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filebox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in processbutton.
function processbutton_Callback(hObject, eventdata, handles)
% hObject    handle to processbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
inputfiles=get(handles.filebox,'String');
disp('*** Starting.');
%loop through files
for filepos=1:length(inputfiles);
    [header,data]=LW_load(inputfiles{filepos});
    load(st,'-MAT');
    %locutoff1,locutoff2,hicutoff1,hicutoff2,bandpass,bandstop
    locutoff1=str2num(get(handles.locutoff1edit,'String'));
    locutoff2=str2num(get(handles.locutoff2edit,'String'));
    hicutoff1=str2num(get(handles.hicutoff1edit,'String'));
    hicutoff2=str2num(get(handles.hicutoff2edit,'String'));
    passband=str2num(get(handles.passbandedit,'String'));
    stopband=str2num(get(handles.stopbandedit,'String'));
    disp(['*** Zero-phase butterworth high-pass filter']);
    [header,data]=LW_butterhigh(header,data,locutoff1,locutoff2,stopband,passband);
    disp(['*** Zero-phase butterworth low-pass filter']);
    [header,data]=LW_butterlow(header,data,hicutoff1,hicutoff2,stopband,passband);
    LW_save(inputfiles{filepos},get(handles.prefixtext,'String'),header,data);
end;
disp('*** Finished.');




% --- Executes on selection change in outputmenu.
function outputmenu_Callback(hObject, eventdata, handles)
% hObject    handle to outputmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes during object creation, after setting all properties.
function outputmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to outputmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in halfcheckbox.
function halfcheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to halfcheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes on selection change in eventmenu.
function eventmenu_Callback(hObject, eventdata, handles)
% hObject    handle to eventmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes during object creation, after setting all properties.
function eventmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to eventmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




function locutoff1edit_Callback(hObject, eventdata, handles)
% hObject    handle to locutoff1edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes during object creation, after setting all properties.
function locutoff1edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to locutoff1edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




function lowidthedit_Callback(hObject, eventdata, handles)
% hObject    handle to lowidthedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes during object creation, after setting all properties.
function lowidthedit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lowidthedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




function endedit_Callback(hObject, eventdata, handles)
% hObject    handle to endedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes during object creation, after setting all properties.
function endedit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to endedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




function hiwidthedit_Callback(hObject, eventdata, handles)
% hObject    handle to hiwidthedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes during object creation, after setting all properties.
function hiwidthedit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hiwidthedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sizeedit_Callback(hObject, eventdata, handles)
% hObject    handle to sizeedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function sizeedit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sizeedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in epochendchk.
function epochendchk_Callback(hObject, eventdata, handles)
% hObject    handle to epochendchk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(handles.epochendchk,'Value')==1;
    set(handles.epochsizechk,'Value',0);
else
    set(handles.epochsizechk,'Value',1);
end;


% --- Executes on button press in epochsizechk.
function epochsizechk_Callback(hObject, eventdata, handles)
% hObject    handle to epochsizechk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(handles.epochsizechk,'Value')==1;
    set(handles.epochendchk,'Value',0);
else
    set(handles.epochendchk,'Value',1);
end;


% --- Executes on button press in locheck.
function locheck_Callback(hObject, eventdata, handles)
% hObject    handle to locheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




function loedit_Callback(hObject, eventdata, handles)
% hObject    handle to loedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes during object creation, after setting all properties.
function loedit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to loedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in hicheck.
function hicheck_Callback(hObject, eventdata, handles)
% hObject    handle to hicheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




function hiedit_Callback(hObject, eventdata, handles)
% hObject    handle to hiedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes during object creation, after setting all properties.
function hiedit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hiedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function locutoff2edit_Callback(hObject, eventdata, handles)
% hObject    handle to locutoff2edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes during object creation, after setting all properties.
function locutoff2edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to locutoff2edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




function hicutoff1edit_Callback(hObject, eventdata, handles)
% hObject    handle to hicutoff1edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes during object creation, after setting all properties.
function hicutoff1edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hicutoff1edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




function hicutoff2edit_Callback(hObject, eventdata, handles)
% hObject    handle to hicutoff2edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes during object creation, after setting all properties.
function hicutoff2edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hicutoff2edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




function stopbandedit_Callback(hObject, eventdata, handles)
% hObject    handle to stopbandedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes during object creation, after setting all properties.
function stopbandedit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stopbandedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




function passbandedit_Callback(hObject, eventdata, handles)
% hObject    handle to passbandedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes during object creation, after setting all properties.
function passbandedit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to passbandedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
