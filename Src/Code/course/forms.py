from django import forms


class ImportIndividualForm(forms.Form):
    user_name = forms.CharField(label='User name', max_length=32,
                               widget=forms.TextInput(
                                   attrs={'class': 'validate', 'required': "true"}))
    stu_id = forms.CharField(label='Student ID', max_length=32,
                               widget=forms.TextInput(
                                   attrs={'class': 'validate', 'required': "true"}))
    email = forms.EmailField(label='Email',
                             widget=forms.EmailInput(
                                 attrs={'class': 'validate', 'required': "true"}))
    GPA = forms.FloatField(label='GPA(Optional)', widget=forms.NumberInput(attrs={'class': 'validate', 'required': "false"}))

class GenerateStudentsForm(forms.Form):
    initial_pwd = forms.CharField(label='Initial password', max_length=64, widget=forms.PasswordInput(
        attrs={'class': 'validate', 'required': "true"}))
