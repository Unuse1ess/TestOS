#include "../kernel/types.h"
#include "ports.h"
#include "pci.h"
#include "screen.h"

#define PCI_MAX_BUS 255
#define PCI_MAX_DEV 31
#define PCI_MAX_FUN 7

#define PCI_BASE_ADDR 0x80000000L

#define CONFIG_ADDR 0xcf8
#define CONFIG_DATA 0xcfc

void get_pci_cfg()
{
	word bus, dev, fun;
	dword addr, data;

	for (bus = 0; bus <= PCI_MAX_BUS; bus++)
		for (dev = 0; dev <= PCI_MAX_DEV; dev++)
			for (fun = 0; fun <= PCI_MAX_FUN; fun++)
			{
				addr = PCI_BASE_ADDR | (bus << 16) | (dev << 11) | (fun << 8);
				
				port_dword_out(CONFIG_ADDR, addr);
				data = port_dword_in(CONFIG_DATA);

				if (((data & 0xffff) != 0xffff) && (data != 0))
				{
					// bus, dev, fun
					kprintf("%d  %d  %d  ", bus, dev, fun);

					// vendorID¡¢deviceID
					kprintf("0x%x  0x%x\n", (data & 0xFFFF), (data & 0xFFFF0000) >> 16);
				}
			}
}