@Echo Off
SetLocal

:begin

echo:
echo ****** ��ֹ�ļ������� ******
echo:

set /p folder=�������ļ��У��˳���ֱ�ӹرմ��ڣ��� 
If Not Exist "%folder%\" Exit/B
If /I "%CD%" NEq "%folder%" PushD %folder%
Set "Cmnd=netsh advfirewall firewall add rule action=block"
echo:
For /R %%a In (*.exe) Do (For %%b In (in out) Do (
      echo ������ֹ %%b ����%%a��
      %Cmnd% name="blocked %%a via script" dir=%%b program="%%a"))

echo:
echo �㶨�ˣ�%folder% ������ exe �ļ��Ľ�ֹ��վ����վ�����ѳɹ�������
echo ----------------------------
echo:

goto begin