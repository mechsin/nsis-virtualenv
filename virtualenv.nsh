
Var VIRTUALENV_EXITCODE
Var VIRTUALENV_PYTHONEXE 

!macro PythonVenv VENVPATH PYTHONVERSION 
  nsExec::ExecToLog 'py -${PYTHONVERSION}'
  Pop $VIRTUALENV_EXITCODE
  ${If} $VIRTUALENV_EXITCODE == 0
    DetailPrint "Python ${PYTHONVERSION} seems to be available"
  ${Else}
    MessageBox MB_OK "Python ${PYTHONVERSION} is not available quitting install"
    Quit
  ${EndIf}
  
  DetailPrint "Creating virtual environment"
  nsExec::ExecToLog 'py -${PYTHONVERSION} -m venv ${VENVPATH}'
  Pop $VIRTUALENV_EXITCODE
  ${If} $VIRTUALENV_EXITCODE == 0
    DetailPrint "Python virtual environment created at ${VENVPATH}"
  ${Else}
    MessageBox MB_OK "The Python virtual environment failed to install quitting install"
    Quit
  ${EndIf}
!macroend

!macro PythonInstallLocal VENVPATH PACKAGENAME LINKS
  DetailPrint "Install ${PACKAGENAME}"
  DetailPrint "Using links from ${LINKS}"
  StrCpy $VIRTUALENV_PYTHONEXE "${VENVPATH}\Scripts\python.exe"
  DetailPrint $VIRTUALENV_PYTHONEXE
  nsExec::ExecToLog '$VIRTUALENV_PYTHONEXE -m pip install --no-index --find-links ${LINKS} ${PACKAGENAME}'
  Pop $VIRTUALENV_EXITCODE
  ${If} $VIRTUALENV_EXITCODE == 0
    DetailPrint "Packages successfully installed"
  ${Else}
    MessageBox MB_OK "Failed to install packages and dependencies"
  ${EndIf}
!macroend

!macro PythonInstallInternet VENVPATH PACKAGENAME
  StrCpy $VIRTUALENV_PYTHONEXE "${VENVPATH}\Scripts\python.exe"
  nsExec::ExecToLog '$VIRTUALENV_PYTHONEXE -m pip install ${PACKAGENAME}'
  Pop $VIRTUALENV_EXITCODE
  ${If} $VIRTUALENV_EXITCODE == 0
    DetailPrint "Packages successfully installed"
  ${Else}
    MessageBox MB_OK "Failed to install packages and dependencies"
  ${EndIf}
!macroend