--!native
--!optimize 2

--// Delta Executor & UNC API Definitions
declare function getgenv(): { [string]: any }
declare function getrenv(): { [string]: any }
declare function getreg(): { [string]: any }
declare function getgc(includeTables: boolean?): { any }
declare function getinstances(): { Instance }
declare function getnilinstances(): { Instance }
declare function getscripts(): { LocalScript | ModuleScript }
declare function getloadedmodules(): { ModuleScript }
declare function getconnections(signal: RBXScriptSignal): { any }
declare function gethui(): Instance

declare function fireclickdetector(detector: ClickDetector, distance: number?): ()
declare function firetouchinterest(part: BasePart, toucher: BasePart, touch: number): ()
declare function gethiddenproperty(object: Instance, property: string): (any, boolean)
declare function sethiddenproperty(object: Instance, property: string, value: any): boolean
declare function setclipboard(data: string): ()
declare function identifyexecutor(): (string, string)
declare function lz4compress(data: string): string
declare function lz4decompress(data: string, size: number): string
--// File System & Network
declare function readfile(path: string): string
declare function writefile(path: string, data: string): ()
declare function appendfile(path: string, data: string): ()
declare function isfile(path: string): boolean
declare function isfolder(path: string): boolean
declare function makefolder(path: string): ()
declare function delfile(path: string): ()
declare function delfolder(path: string): ()
declare function listfiles(path: string): { string }
declare function loadstring(source: string, chunkname: string?): ( ...any ) -> ( ...any )
declare function require(module: ModuleScript | number): any

--// Custom GHZ Functions
declare GHZ_REMOTE: (path: string) -> any

--// Custom EfHub Functions
declare function fLog(message: any): ()

--// Global Services (Exploit Environment)
declare CoreGui: Instance
declare CollectionService: any