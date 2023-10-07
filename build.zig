const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const lib = b.addStaticLibrary(.{
        .name = "macos-sdk",
        .root_source_file = .{ .path = "stub.c" },
        .target = target,
        .optimize = optimize,
    });
    lib.linkLibC();
    lib.addSystemFrameworkPath(.{ .path = "Frameworks" });
    lib.addSystemIncludePath(.{ .path = "include" });
    lib.addLibraryPath(.{ .path = "lib" });
    b.installArtifact(lib);
}
