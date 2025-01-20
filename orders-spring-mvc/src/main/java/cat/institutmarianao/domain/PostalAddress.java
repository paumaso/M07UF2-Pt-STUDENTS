package cat.institutmarianao.domain;

import java.io.Serializable;
import java.util.Objects;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

public class PostalAddress implements Serializable {

	private static final long serialVersionUID = 1L;

	private static final int MAX_ADDRESS = 150;
	private static final int MAX_ZIP_CODE = 20;
	private static final int MAX_CITY = 150;
	private static final int MAX_STATE = 150;
	private static final int MAX_COUNTRY = 150;

	private String recipientName;

    @NotBlank(message = "{NotBlank.order.deliveryAddress.address}")
	@Size(max = MAX_ADDRESS, message = "{Size.order.deliveryAddress.address}")
	private String address;

    @NotBlank(message = "{NotBlank.order.deliveryAddress.zipCode}")
	@Size(max = MAX_ZIP_CODE, message = "{Size.order.deliveryAddress.zipCode}")
	private String zipCode;

    @NotBlank(message = "{NotBlank.order.deliveryAddress.city}")
	@Size(max = MAX_CITY, message = "{Size.order.deliveryAddress.city}")
	private String city;

    @NotBlank(message = "{NotBlank.order.deliveryAddress.state}")
	@Size(max = MAX_STATE, message = "{Size.order.deliveryAddress.state}")
	private String state;

    @NotBlank(message = "{NotBlank.order.deliveryAddress.country}")
	@Size(max = MAX_COUNTRY, message = "{Size.order.deliveryAddress.country}")
	private String country;

	public String getRecipientName() {
		return recipientName;
	}

	public void setRecipientName(String recipientName) {
		this.recipientName = recipientName;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getZipCode() {
		return zipCode;
	}

	public void setZipCode(String zipCode) {
		this.zipCode = zipCode;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	@Override
	public int hashCode() {
		return Objects.hash(address, city, country, recipientName, state, zipCode);
	}

	@Override
	public boolean equals(Object object) {
		if (this == object) {
			return true;
		}
		if (object instanceof PostalAddress postalAddress) {
			return Objects.equals(address, postalAddress.address) && Objects.equals(city, postalAddress.city)
					&& Objects.equals(country, postalAddress.country)
					&& Objects.equals(recipientName, postalAddress.recipientName)
					&& Objects.equals(state, postalAddress.state) && Objects.equals(zipCode, postalAddress.zipCode);
		}
		return false;
	}
	
	@Override
    public String toString() {
        return "PostalAddress{" +
        		"name='" + recipientName + '\'' + 
                "street='" + address + '\'' +
                ", city='" + city + '\'' +
                ", postalCode='" + zipCode + '\'' +
                '}';
    }

}
