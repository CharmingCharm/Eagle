from django import forms


class AddSubmissionItemForm(forms.Form):
    title = forms.CharField(label='title', max_length=128,
                            widget=forms.TextInput(
                                attrs={'id': 'icon_prefix', 'required': "true"}))

    percentage = forms.FloatField(label='percentage',
                                  widget=forms.TextInput(
                                      attrs={'id': 'icon_per', 'required': "true"}))
