Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E65616B6A0
	for <lists+linux-block@lfdr.de>; Tue, 25 Feb 2020 01:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbgBYAUK (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 24 Feb 2020 19:20:10 -0500
Received: from avon.wwwdotorg.org ([104.237.132.123]:53770 "EHLO
        avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbgBYAUK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Feb 2020 19:20:10 -0500
Received: from [10.20.204.51] (unknown [216.228.112.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by avon.wwwdotorg.org (Postfix) with ESMTPSA id DD3721C03C9;
        Mon, 24 Feb 2020 17:20:07 -0700 (MST)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.1 at avon.wwwdotorg.org
Subject: Re: [PATCH v1 3/3] partitions: Introduce NVIDIA Tegra Partition Table
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Billy Laws <blaws05@gmail.com>, linux-tegra@vger.kernel.org,
        linux-block@vger.kernel.org, Andrey Danin <danindrey@mail.ru>,
        Gilles Grandou <gilles@grandou.net>,
        Ryan Grachek <ryan@edited.us>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200224231841.26550-1-digetx@gmail.com>
 <20200224231841.26550-4-digetx@gmail.com>
From:   Stephen Warren <swarren@wwwdotorg.org>
Message-ID: <44c22925-a14e-96d0-1f93-1979c0c60525@wwwdotorg.org>
Date:   Mon, 24 Feb 2020 17:20:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200224231841.26550-4-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/24/20 4:18 PM, Dmitry Osipenko wrote:
> All NVIDIA Tegra devices use a special partition table format for the
> internal storage partitioning. Most of Tegra devices have GPT partition
> in addition to TegraPT, but some older Android consumer-grade devices do
> not or GPT is placed in a wrong sector, and thus, the TegraPT is needed
> in order to support these devices properly in the upstream kernel. This
> patch adds support for NVIDIA Tegra Partition Table format that is used
> at least by all NVIDIA Tegra20 and Tegra30 devices.

> diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c

> +static void __init tegra_boot_config_table_init(void)
> +{
> +	void __iomem *bct_base;
> +	u16 pt_addr, pt_size;
> +
> +	bct_base = IO_ADDRESS(TEGRA_IRAM_BASE) + TEGRA_IRAM_BCT_OFFSET;

This shouldn't be hard-coded. IIRC, the boot ROM writes a BIT (Boot 
Information Table) to a fixed location in IRAM, and there's some value 
in the BIT that points to where the BCT is in IRAM. In practice, it 
might work out that the BCT is always at the same place in IRAM, but 
this certainly isn't guaranteed. I think there's code in U-Boot which 
extracts the BCT location from the BIT? Yes, see 
arch/arm/mach-tegra/ap.c:get_odmdata().
