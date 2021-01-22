
#include "../kernel/types.h"
#include "ports.h"
#include "screen.h"


uint16_t pciConfigReadWord(uint8_t bus, uint8_t slot, uint8_t func, uint8_t offset)
{
	uint32_t address;
	uint32_t lbus = (uint32_t)bus;
	uint32_t lslot = (uint32_t)slot;
	uint32_t lfunc = (uint32_t)func;
	uint16_t tmp = 0;

	/* create configuration address as per Figure 1 */
	address = (uint32_t)((lbus << 16) | (lslot << 11) |
		(lfunc << 8) | (offset & 0xfc) | ((uint32_t)0x80000000));

	/* write out the address */
	port_word_out(0xCF8, address);
	/* read in the data */
	/* (offset & 2) * 8) = 0 will choose the first word of the 32 bits register */
	tmp = (uint16_t)((port_word_in(0xCFC) >> ((offset & 2) * 8)) & 0xffff);
	return (tmp);
}


void checkAllBuses(void)
{
	uint16_t bus, ret;
	uint8_t device, devID, vendorID;
	word class_code;

	for (bus = 0; bus < 256; bus++)
	{
		for (device = 0; device < 32; device++)
		{
			vendorID = pciConfigReadWord(bus, device, 0, 0);
			if (vendorID != 0xFFFF)
			{
				devID = pciConfigReadWord(bus, device, 0, 2);
				class_code = pciConfigReadWord(bus, device, 0, 0xA);
				kprintf("vendor 0x%x ", vendorID);
				kprintf("bus 0x%x device 0x%x devID 0x%x ", bus, device, devID);
				kprintf("class code 0x%x\n", class_code);
			}
		}
	}
}

