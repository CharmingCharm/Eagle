from django import forms


class LoginForm(forms.Form):
    username = forms.CharField(label='username', max_length=32,
                               widget=forms.TextInput(
                                   attrs={'class': 'validate', 'placeholder': 'Username', 'required': "true"}))
    password = forms.CharField(label='password', max_length=64,
                               widget=forms.PasswordInput(
                                   attrs={'class': 'form-control', 'placeholder': 'Password', 'required': "true"}))


class RegisterForm(forms.Form):
    username = forms.CharField(label='username', max_length=32,
                               widget=forms.TextInput(
                                   attrs={'class': 'form-control', 'placeholder': 'Username', 'required': "true"}))
    email = forms.EmailField(label='email address',
                             widget=forms.EmailInput(
                                 attrs={'class': 'form-control', 'placeholder': 'Email address', 'required': "true"}))
    password = forms.CharField(label='password', max_length=64,
                               widget=forms.PasswordInput(
                                   attrs={'class': 'form-control', 'placeholder': 'Password', 'required': "true"}))
    # confirm_password = forms.CharField(label='confirm password', max_length=64,
    # widget = forms.PasswordInput( attrs={'class': 'form-control', 'placeholder': 'confirm your password'}))
