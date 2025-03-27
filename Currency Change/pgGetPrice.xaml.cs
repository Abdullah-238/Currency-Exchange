namespace Currency_Change;

public partial class pgGetPrice : ContentPage
{
    clsRates rates;


    SortedList<string, double> Currencies;

    public pgGetPrice()
	{
		InitializeComponent();

        rates = new clsRates();

        Currencies = rates.Obj.conversion_rates;

    }

    private void dtpFinCurrencyPrice_SelectedIndexChanged(object sender, EventArgs e)
    {
        double Price = rates.Obj.conversion_rates[dtpFinCurrencyPrice.SelectedItem.ToString()];

        enPrice.Text = Price.ToString();

    }

    private void ContentPage_Loaded(object sender, EventArgs e)
    {
        dtpFinCurrencyPrice.ItemsSource = clsConversionRate.CurrencyCodes;

        dtpFinCurrencyPrice.SelectedIndex = 0;
    }
}