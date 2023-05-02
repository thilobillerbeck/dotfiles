{ config, pkgs, lib, ... }:

{
  programs.htop = {
      enable = true;
      settings = {
        fields="0 48 17 18 38 39 40 2 46 47 49 1";
        sort_key="46";
        sort_direction="1";
        tree_sort_key="0";
        tree_sort_direction="1";
        hide_kernel_threads="1";
        hide_userland_threads="0";
        shadow_other_users="0";
        show_thread_names="0";
        show_program_path="1";
        highlight_base_name="0";
        highlight_megabytes="1";
        highlight_threads="1";
        highlight_changes="0";
        highlight_changes_delay_secs="5";
        find_comm_in_cmdline="1";
        strip_exe_from_cmdline="1";
        show_merged_command="0";
        tree_view="1";
        tree_view_always_by_pid="0";
        header_margin="1";
        detailed_cpu_time="0";
        cpu_count_from_one="0";
        show_cpu_usage="1";
        show_cpu_frequency="0";
        show_cpu_temperature="0";
        degree_fahrenheit="0";
        update_process_names="0";
        account_guest_in_cpu_meter="0";
        color_scheme="0";
        enable_mouse="1";
        delay="15";
        left_meters="LeftCPUs2 CPU Memory DiskIO NetworkIO";
        left_meter_modes="1 1 1 2 2";
        right_meters="RightCPUs2 Tasks LoadAverage Uptime Battery";
        right_meter_modes="1 2 2 2 2";
        hide_function_bar="0";
      };
    };
}
