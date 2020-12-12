#ifndef PCI_H
#define PCI_H

#define PCI_CONFIGURE_ADDR			0xCF8
#define PCI_CONFIGURE_DATA			0xCFC

#define PDI_BUS_SHIFT   8
#define PDI_BUS_SIZE    8
#define PDI_BUS_MAX     0xFF
#define PDI_BUS_MASK    0xFF00
#define PDI_DEVICE_SHIFT   3
#define PDI_DEVICE_SIZE    5
#define PDI_DEVICE_MAX     0x1F
#define PDI_DEVICE_MASK    0x00F8
#define PDI_FUNCTION_SHIFT   0
#define PDI_FUNCTION_SIZE    3
#define PDI_FUNCTION_MAX     0x7
#define PDI_FUNCTION_MASK    0x0007
#define MK_PDI(bus,dev,func) (word)((bus&PDI_BUS_MAX)<<PDI_BUS_SHIFT | (dev&PDI_DEVICE_MAX)<<PDI_DEVICE_SHIFT | (func&PDI_FUNCTION_MAX))

/* PCIÅäÖÃ¿Õ¼ä¼Ä´æÆ÷ */
#define PCI_CONFIG_ADDRESS      0xCF8
#define PCI_CONFIG_DATA         0xCFC
/* Ìî³äPCI_CONFIG_ADDRESS */
#define MK_PCICFGADDR(bus,dev,func) (dword)(0x80000000L | (dword)MK_PDI(bus,dev,func)<<8)

#endif