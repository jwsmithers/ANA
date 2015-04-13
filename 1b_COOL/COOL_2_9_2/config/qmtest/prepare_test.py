#!/usr/bin/env python

import sys, os

from optparse import OptionParser

class BasicTest:
    tmpl = """<?xml version="1.0" ?>
<!DOCTYPE extension  PUBLIC '-//QM/2.3/Extension//EN'  'http://www.codesourcery.com/qm/dtds/2.3/-//qm/2.3/extension//en.dtd'>
<extension class="COOLTests.StandardTest" kind="test">
  <argument name="stdin"><text/></argument>
  <argument name="timeout"><integer>-1</integer></argument>
  <argument name="stdout"><text/></argument>
  <argument name="prerequisites">%(prereq)s</argument>
  <argument name="target_group"><text>.*</text></argument>
  <argument name="exit_code"><integer>0</integer></argument>
  <argument name="environment">%(env)s</argument>
  <argument name="command"><text>%(cmd)s</text></argument>
  <argument name="stderr">%(stderr)s</argument>
  <argument name="resources"><set/></argument>
  <argument name="unsupported_platforms">%(unsupported)s</argument>
</extension>
"""
    ext = "qmt"
    def __init__(self, cmd, name=None, depends = [], env = {}, stderr = None, unsupported = ""):
        self.name = name
        self.cmd = cmd
        self.depends = depends[:]
        self.env = env.copy()
        self.stderr = stderr
        self.unsupported = unsupported
        self.isSuite = False
        self._saving = False

        if not self.name:
            # try to guess from command name
            self.name = cmd.replace("test_","").lower()

    def __str__(self):
        return self.name

    def filename(self,ext):
        levels = self.name.split('.')
        levels[-1] += "." + ext
        path = ""
        for n in range(len(levels)-1):
            levels[n] += ".qms"
            path = os.path.join(path, levels[n])
        return os.path.join(path,levels[-1])

    def write(self,f,data,force=False):
        d = os.path.dirname(f)
        if d and not os.path.exists(d):
            print "making dir %s"%d
            os.makedirs(d)
        if force or not os.path.exists(f):
            print "write to file %s"%f
            open(f,"w").write(data)
        else:
            #raise RuntimeError("file '%s.qmt' already exists"%self)
            pass

    def dep_str(self):
        return "\n    <tuple><text>%s</text><enumeral>PASS</enumeral></tuple>"%self.name

    def data(self):
        data = {}
        data["cmd"] = self.cmd
        data["prereq"] = "<set/>"
        data["env"] = "<set/>"
        data["stderr"] = "<text/>"
        data["unsupported"] = "<text/>"

        if self.depends :
            tmp = "<set>"
            for t in self.depends:
                try:
                    tmp += t.dep_str()
                except AttributeError:
                    tmp += "\n    <tuple><text>%s</text><enumeral>PASS</enumeral></tuple>"%t
                    pass
            tmp += "\n  </set>"
            data["prereq"] = tmp
        if self.env:
            env_str = "<set>"
            for n,v in self.env.items():
                env_str += "\n    <text>%s=%s</text>"%(n,v)
            env_str += "\n  </set>"
            data["env"] = env_str
        if self.stderr:
            data["stderr"] = "<text>%s</text>"%self.stderr
        if self.unsupported:
            data["unsupported"] = "<text>%s</text>"%self.unsupported
        return data
    
    def save(self,force = False):
        if self._saving:
            all = ""
            for n in self.depends:
                all += "%s\n"%n
            raise RuntimeError("dependency loop!!! (%s)\n%s"%(self,all))
        self._saving = True

        # recursion
        for t in self.depends:
            try:
                t.save(force)
            except AttributeError:
                # if t is a string, it does not have the save method
                pass

        data = self.data()

        self.write(self.filename(self.ext),self.tmpl%data,force)
    
        self._saving = False

class TestSuite(BasicTest):
    tmpl = """<?xml version="1.0" ?>
<!DOCTYPE extension  PUBLIC '-//QM/2.3/Extension//EN'  'http://www.codesourcery.com/qm/dtds/2.3/-//qm/2.3/extension//en.dtd'>
<extension class="explicit_suite.ExplicitSuite" kind="suite">
  <argument name="suite_ids">%(suites)s</argument>
  <argument name="test_ids">%(tests)s</argument>
</extension>
"""
    ext = "qms"
    def __init__(self, name, members = []):
        BasicTest.__init__(self, cmd = None, name = name)
        self.members = members[:]
        self.isSuite = True

    def dep_str(self):
        res = ""
        for t in self.members:
            try:
                res += t.dep_str()
            except AttributeError:
                res += "\n    <tuple><text>%s</text><enumeral>PASS</enumeral></tuple>"%t
                pass
        return res
    
    def data(self):
        data = {}
        data["suites"] = "<set/>"
        data["tests"] = "<set/>"
        suites = []
        tests = []
        for m in self.members:
            try:
                if m.isSuite:
                    suites.append(m)
                else:
                    tests.append(m)
            except AttributeError,x:
                if os.path.exists("%s.qms"%m): suites.append(m)
                elif os.path.exists("%s.qmt"%m): tests.append(m)
        if tests:
            tmp = "<set>"
            for t in tests:
                tmp += "\n    <text>%s</text>"%t
            tmp += "\n  </set>"
            data["tests"] = tmp
        if suites:
            tmp = "<set>"
            for t in suites:
                tmp += "\n    <text>%s</text>"%t
            tmp += "\n  </set>"
            data["suites"] = tmp
        return data

    def save(self,force = False):
        if self._saving:
            all = ""
            for n in self.depends:
                all += "%s\n"%n
            raise RuntimeError("dependency loop!!! (%s)\n%s"%(self,all))
        self._saving = True

        # recursion
        for t in self.members:
            try:
                t.save(force)
            except AttributeError:
                # if t is a string, it does not have the save method
                pass

        data = self.data()

        self.write(self.filename(self.ext),self.tmpl%data,force)
            
        self._saving = False

class DatabaseTest(BasicTest):
    tmpl = """<?xml version="1.0" ?>
<!DOCTYPE extension  PUBLIC '-//QM/2.3/Extension//EN'  'http://www.codesourcery.com/qm/dtds/2.3/-//qm/2.3/extension//en.dtd'>
<extension class="COOLTests.DatabaseTest" kind="test">
  <argument name="stdin"><text/></argument>
  <argument name="timeout"><integer>-1</integer></argument>
  <argument name="stdout"><text/></argument>
  <argument name="prerequisites">%(prereq)s</argument>
  <argument name="target_group"><text>.*</text></argument>
  <argument name="exit_code"><integer>0</integer></argument>
  <argument name="environment">%(env)s</argument>
  <argument name="command"><text>%(cmd)s</text></argument>
  <argument name="stderr">%(stderr)s</argument>
  <argument name="resources"><set/></argument>
  <argument name="db_type"><enumeral>%(backend)s</enumeral></argument>
  <argument name="package_name"><enumeral>%(package)s</enumeral></argument>
  <argument name="unsupported_platforms">%(unsupported)s</argument>
</extension>
"""
    def __init__(self, cmd, name=None, db = "SQLite", package = "RelationalCool", depends = [], env = {}, stderr = None, unsupported = ""):
        BasicTest.__init__(self,cmd,name,depends,env,stderr,unsupported)
        self.db = db
        self.package = package
        
    def data(self):
        data = BasicTest.data(self)
        data["backend"] = self.db
        data["package"] = self.package
        return data

class SourceTargetTest(DatabaseTest):
    tmpl = """<?xml version="1.0" ?>
<!DOCTYPE extension  PUBLIC '-//QM/2.3/Extension//EN'  'http://www.codesourcery.com/qm/dtds/2.3/-//qm/2.3/extension//en.dtd'>
<extension class="COOLTests.SourceTargetTest" kind="test">
  <argument name="stdin"><text/></argument>
  <argument name="timeout"><integer>-1</integer></argument>
  <argument name="stdout"><text/></argument>
  <argument name="prerequisites">%(prereq)s</argument>
  <argument name="target_group"><text>.*</text></argument>
  <argument name="exit_code"><integer>0</integer></argument>
  <argument name="environment">%(env)s</argument>
  <argument name="command"><text>%(cmd)s</text></argument>
  <argument name="stderr">%(stderr)s</argument>
  <argument name="resources"><set/></argument>
  <argument name="db_type"><enumeral>%(backend)s</enumeral></argument>
  <argument name="package_name"><enumeral>%(package)s</enumeral></argument>
  <argument name="unsupported_platforms">%(unsupported)s</argument>
</extension>
"""

class EvolutionTest(DatabaseTest):
    tmpl = """<?xml version="1.0" ?>
<!DOCTYPE extension  PUBLIC '-//QM/2.3/Extension//EN'  'http://www.codesourcery.com/qm/dtds/2.3/-//qm/2.3/extension//en.dtd'>
<extension class="COOLTests.EvolutionTest" kind="test">
  <argument name="stdin"><text/></argument>
  <argument name="timeout"><integer>-1</integer></argument>
  <argument name="stdout"><text/></argument>
  <argument name="prerequisites">%(prereq)s</argument>
  <argument name="target_group"><text>.*</text></argument>
  <argument name="exit_code"><integer>0</integer></argument>
  <argument name="environment">%(env)s</argument>
  <argument name="command"><text/></argument>
  <argument name="stderr">%(stderr)s</argument>
  <argument name="resources"><set/></argument>
  <argument name="db_type"><enumeral>%(backend)s</enumeral></argument>
  <argument name="package_name"><enumeral>%(package)s</enumeral></argument>
  <argument name="original"><enumeral>%(original)s</enumeral></argument>
  <argument name="unsupported_platforms">%(unsupported)s</argument>
</extension>
"""
    def __init__(self, name=None, db = "SQLite", package = "RelationalCool", depends = [], env = {}, stderr = None, unsupported = "", original = "1.3.0"):
        DatabaseTest.__init__(self,"",name,db,package,depends,env,stderr,unsupported)
        self.original = original
        
    def data(self):
        data = DatabaseTest.data(self)
        data["original"] = self.original
        del data["cmd"]
        return data

if __name__ == "__main__":
    parser = OptionParser()
    parser.add_option("-n", "--name", dest="name",
                      help="name of the test")
    parser.add_option("-c", "--cmd", dest = "cmd",
                      help="command to run")
    parser.add_option("-d", "--db", dest = "db",
                      help="database to use")
    parser.add_option("-l", "--depend", dest = "depends",
                      action = "append",
                      help="test to be run before")
    
    (options, args) = parser.parse_args()
    if 'cmd' not in options and 'name' not in options:
        print "I need at least a name and a command (try with -h)"
        sys.exit(1)

    BasicTest(options.name, options.cmd, options.db, options.depends).save()
