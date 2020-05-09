from django import forms
from django.forms import formset_factory


class SubmissionItemForm(forms.Form):
    title = forms.CharField(label='title', max_length=128,
                            widget=forms.TextInput(
                                attrs={'id': 'icon_prefix', 'required': "true"}))

    percentage = forms.FloatField(label='percentage',
                                  widget=forms.NumberInput(
                                      attrs={'id': 'icon_per', 'required': "true"}))
